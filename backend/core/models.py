"""
Models for core app.
"""
import uuid
from django.db import models
from django.core.mail import send_mail
from django.contrib.auth.base_user import AbstractBaseUser
from django.contrib.auth.models import PermissionsMixin
from django.utils.translation import ugettext_lazy as _
from .managers import UserManager
from .validators import USERNAME_VALIDATOR


class User(AbstractBaseUser, PermissionsMixin):
    """
    User model.
    """
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    username = models.CharField(max_length=30, validators=[USERNAME_VALIDATOR], unique=True)
    first_name = models.CharField(_('first name'), max_length=50)
    last_name = models.CharField(_('last name'), max_length=50)
    email = models.EmailField(_('email address'), unique=True)
    date_of_birth = models.DateField(_('date of birth'))
    GENDER_CHOICES = (
        ('MALE', _('Male')),
        ('FEMALE', _('Female')),
        ('OTHER', _('Other')),
        ('', _('Unrevealed')),
    )
    gender = models.CharField(_("gender"), max_length=6, choices=GENDER_CHOICES,
                              default='', blank=True)
    # profile
    position = models.CharField(max_length=30, null=True, blank=True)
    company = models.CharField(max_length=30, null=True, blank=True)
    is_speaker = models.BooleanField(default=False)

    is_active = models.BooleanField(_('active'), default=True)
    email_confirmed = models.BooleanField(default=False)
    date_joined = models.DateTimeField(_('date joined'), auto_now_add=True)

    objects = UserManager()
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['first_name', 'last_name', 'username', 'date_of_birth']

    def __str__(self):
        return self.get_full_name()

    @property
    def is_staff(self):
        """
        Is the user a staff member?
        """
        if self.is_superuser:
            return True
        return False

    def get_full_name(self):
        """
        Returns the first_name and the last_name, with a space in between.
        """
        full_name = "{} {}".format(self.first_name, self.last_name)
        return full_name.strip()

    def get_short_name(self):
        """
        Returns the short name for the user.
        """
        return self.first_name

    def email_user(self, subject, message, from_email=None, **kwargs):
        """
        Sends an email to this user.
        """
        send_mail(subject, message, from_email, [self.email], **kwargs)


class Location(models.Model):
    """
    Location model.
    Used for building direction maps.
    """
    latitude = models.FloatField()
    longitude = models.FloatField()
    floor = models.SmallIntegerField()
    # x = models.FloatField()
    # y = models.FloatField()
    # z = models.FloatField()

    def __str__(self):
        return '[{}, {}, floor_{}]'.format(self.latitude, self.longitude, self.floor)


class Beacon(models.Model):
    """
    Beacon model.
    Used in the implementation of direction maps.
    """
    mac_address = models.CharField(max_length=17)
    location = models.ForeignKey(Location, on_delete=models.PROTECT)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return '[{},{}]'.format(self.id, self.is_active)


class Tag(models.Model):
    """
    Tag model.
    Used as an interest category for events.
    """
    name = models.CharField(max_length=30)

    def __str__(self):
        return '{}'.format(self.name)


class Place(models.Model):
    """
    Room model.
    Used as the location of events.
    """
    name = models.CharField(max_length=30)
    location = models.ForeignKey(Location, on_delete=models.PROTECT)
    PLACE_TYPES = (
        ('ROOM', _('Room')),
        ('COFFEE', _('Coffee')),
        ('STAIRS', _('Stairs')),
        ('JOINT', _('Joint')),
        ('', _('Undefined')),
    )
    place_type = models.CharField(_("type"), max_length=10, choices=PLACE_TYPES,
                                  default='', blank=True)
    # bealocation = models.ManyToManyField(Beacon) # geolocation of beacons

    def __str__(self):
        return '{}'.format(self.name)


class MapEdge(models.Model):
    """
    Map edge model.
    Used for building the direction graph.
    """
    vertex1 = models.ForeignKey(Place, related_name='vertex1', on_delete=models.CASCADE)
    vertex2 = models.ForeignKey(Place, related_name='vertex2', on_delete=models.CASCADE)


class Event(models.Model):
    """
    Event model.
    """
    name = models.CharField(max_length=30)
    description = models.TextField()
    tag = models.ForeignKey(Tag, on_delete=models.PROTECT)
    room = models.ForeignKey(Place, on_delete=models.PROTECT)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    updates = models.TextField(null=True, blank=True, default=None)

    def __str__(self):
        return '{}'.format(self.name)


class Bookmarks(models.Model):
    """
    Bookmarks model.
    Used for bookmarking events.
    """
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    event = models.ForeignKey(Event, on_delete=models.CASCADE)

    def __str__(self):
        return '{} -> {}'.format(self.user, self.event.name)


class Notification(models.Model):
    """
    Notification model.
    Used to mobile notifications.
    """
    name = models.CharField(max_length=30)
    description = models.TextField()

    def __str__(self):
        return '{}'.format(self.name)
