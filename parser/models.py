from django.db import models


class Article(models.Model):
    title = models.CharField()
    url = models.URLField()
    author_name = models.CharField()
    author_link = models.URLField()
    publish_date = models.DateTimeField()
    text = models.TextField()
