FROM python:3.12.2-alpine3.19

WORKDIR /usr/src/app

RUN apk update

RUN pip install --upgrade pip
RUN apk -U upgrade

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY ../ .

RUN chmod +x /usr/src/app/entrypoint.sh

ENTRYPOINT ["/usr/src/app/entrypoint.sh"]