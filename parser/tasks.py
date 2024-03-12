from bs4 import BeautifulSoup
import requests
from fake_useragent import UserAgent
import asyncio
import aiohttp
from celery import Celery

from .models import Article, Hub


semaphore = asyncio.Semaphore(5)  # указываем максимальное количество асинхронных запросов


app = Celery('habr_parser')
app.config_from_object('django.conf:settings')


async def fetch(session, article: dict, headers: dict) -> dict:
    async with semaphore:
        async with session.get(article['url'], headers=headers) as response:
            raw_article = {
                'hub_id': article['hub_id'],
                'title': article['title'],
                'url': article['url'],
                'html': await response.text(),
            }
            return raw_article


async def fetch_all(articles: list, loop, headers):
    async with aiohttp.ClientSession(loop=loop) as session:
        results = await asyncio.gather(
            *[fetch(session, article, headers) for article in articles],
            return_exceptions=True
        )
        return results


def parse_hab(hub: Hub, headers: dict) -> list[dict]:
    """Возвращает список словарей с ключами: hub_id, title, url"""
    req = requests.get(url=hub.url, headers=headers).text

    soup = BeautifulSoup(req, 'lxml')
    all_hrefs_articles = soup.find_all('a', class_='tm-title__link')  # получаем статьи

    articles = [
        {
            'hub_id': hub.id,
            'title': article.find('span').text,  # собираем названия статей
            'url': f'https://habr.com{article.get("href")}'  # ссылки на статьи
        } for article in all_hrefs_articles
    ]

    return articles


def parse_article(raw_article) -> dict | None:
    """Возвращает статью в виде словаря с ключами: author_name, author_link, publish_date, text"""
    article_dict = {}

    soup = BeautifulSoup(raw_article, 'lxml')

    author = soup.find('a', class_='tm-user-info__username')

    if not author:
        return

    article_dict['author_name'] = author.text.strip()
    article_dict['author_link'] = f'https://habr.com{author.get("href")}'

    date = soup.find('span', class_='tm-article-datetime-published')
    article_dict['publish_date'] = date.find('time')['datetime']

    text = soup.find('div', id='post-content-body')
    article_dict['text'] = text.text

    return article_dict


@app.task(bind=True)
def parser(self):
    """Задача"""
    ua = UserAgent()

    headers = {
        'accept': 'application/json, text/plain, */*',
        'user-Agent': ua.google,
    }

    articles = []
    # берем хабы из базы данных
    hubs = Hub.objects.all()
    # и собираем с них названия и ссылки на статьи
    for hub in hubs:
        articles.extend(parse_hab(hub, headers))

    # отбираем статьи которые ранее не парсились
    parsed_articles = Article.objects.filter(url__in=[article['url'] for article in articles])
    parsed_urls = [article.url for article in parsed_articles]
    not_parsed_articles = [article for article in articles if article['url'] not in parsed_urls]

    # асинхронно запрашиваем статьи с хабра
    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    raw_articles = loop.run_until_complete(fetch_all(not_parsed_articles, loop, headers))

    # парсим статьи и сохраняем в базу данных
    done_articles = []
    for raw_article in raw_articles:
        article = parse_article(raw_article['html'])
        done_articles.append(
            Article(
                title=raw_article['title'],
                url=raw_article['url'],
                author_name=article['author_name'],
                author_link=article['author_link'],
                publish_date=article['publish_date'],
                text=article['text'],
                hub_id=raw_article['hub_id'],
            )
        )
    Article.objects.bulk_create(done_articles)
