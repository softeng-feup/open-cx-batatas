from django.db import models


class Location(models.Model):
    x = models.FloatField()
    y = models.FloatField()
    z = models.FloatField()

    def __str__(self):
        return '[{}, {}, {}]'.format(self.x, self.y, self.z)

class Event(models.Model):
    """
    The event model.
    """
    name = models.CharField(max_length=30)
    description = models.TextField()
    # tag
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    updates = models.TextField(null=True, blank=True, default=None)

class Tag(models.Model):
    name = models.CharField(max_length=30)

class Beacon(models.Model):
    isActive = models.BooleanField()

class Notification(models.Model):
    name = models.CharField(max_length=30)
    description = models.TextField()

#class User(models.User):
#    isPrivate =  models.BooleanField()

class Room(models.Model):
    name = models.CharField(max_length=30)
