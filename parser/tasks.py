from bs4 import BeautifulSoup
import requests
from fake_useragent import UserAgent
import asyncio
import aiohttp
from celery import Celery

from .models import Article


app = Celery('habr_parser')
app.config_from_object('django.conf:settings')


async def fetch(session, title: str, url: str, headers: dict) -> dict:
    async with session.get(url, headers=headers) as response:
        raw_article = {
            'title': title,
            'url': url,
            'html': await response.text(),
        }
        return raw_article


async def fetch_all(articles_dict: dict, loop, headers):
    async with aiohttp.ClientSession(loop=loop) as session:
        results = await asyncio.gather(
            *[fetch(session, title, url, headers) for title, url in articles_dict.items()],
            return_exceptions=True
        )
        return results


def parse_main(headers: dict) -> dict:
    article_dict = {}

    url = f'https://habr.com/ru/articles/'

    req = requests.get(url, headers=headers).text

    soup = BeautifulSoup(req, 'lxml')
    all_hrefs_articles = soup.find_all('a', class_='tm-title__link')  # получаем статьи

    for article in all_hrefs_articles:  # проходимся по статьям
        article_name = article.find('span').text  # собираем названия статей
        article_link = f'https://habr.com{article.get("href")}'  # ссылки на статьи
        article_dict[article_name] = article_link

    return article_dict


def parse_article(raw_article) -> dict:
    article_dict = {}

    soup = BeautifulSoup(raw_article, 'lxml')

    author = soup.find('a', class_='tm-user-info__username')
    article_dict['author_name'] = author.text.strip()
    article_dict['author_link'] = f'https://habr.com{author.get("href")}'

    date = soup.find('span', class_='tm-article-datetime-published')
    article_dict['publish_date'] = date.find('time')['datetime']

    text = soup.find('div', id='post-content-body')
    article_dict['text'] = text.text

    return article_dict


@app.task(bind=True)
def parser(self):
    ua = UserAgent()

    headers = {
        'accept': 'application/json, text/plain, */*',
        'user-Agent': ua.google,
    }

    article_dict = parse_main(headers)

    titles = article_dict.keys()
    to_remove = []
    for title in titles:
        if Article.objects.filter(title=title).exists():
            to_remove.append(title)
    for title in to_remove:
        del article_dict[title]

    loop = asyncio.new_event_loop()
    asyncio.set_event_loop(loop)
    raw_articles = loop.run_until_complete(fetch_all(article_dict, loop, headers))

    for raw_article in raw_articles:
        article = parse_article(raw_article['html'])
        article = Article(
            title=raw_article['title'],
            url=raw_article['url'],
            author_name=article['author_name'],
            author_link=article['author_link'],
            publish_date=article['publish_date'],
            text=article['text']
        )
        article.save()
