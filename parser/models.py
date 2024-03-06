from django.db import models


class Hub(models.Model):
    name = models.CharField()
    url = models.URLField()

    def __str__(self):
        return self.name


class Article(models.Model):
    title = models.CharField()
    url = models.URLField()
    author_name = models.CharField()
    author_link = models.URLField()
    publish_date = models.DateTimeField()
    text = models.TextField()
    hub = models.ForeignKey(Hub, on_delete=models.CASCADE)

    def __str__(self):
        return self.title
