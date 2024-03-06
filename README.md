# Парсер хабов с Habr
Принцип работы:
периодически парсит статьи с выбранных хабов и сохраняет в базу данных

## Технологии
- Python 3.12
- django
- aiohttp
- celery
- redis
- postgresql
- docker

## Запуск
1. Убедитесь, что у вас установлены docker, docker-compose, make
2. Запустите докер:
```sh
$ systemctl start docker
```
3. Соберите и запустите контейнеры:
```sh
$ make build_run
```
4. Чтобы сразу добавить несколько хабов и настройки планировщика в базу данных выполните команду:
```sh
$ make db_restore
```

## Использование
Добавлять/удалять хабы и настраивать периодичность их парсинга можно в админке django, для этого после запуска контейнера перейдите в браузере по адресу 0.0.0.0:8000/admin,

данные для входа в админку: superuser notdefaultpassword
