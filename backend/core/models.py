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
    x = models.FloatField()
    y = models.FloatField()
    z = models.FloatField()

    def __str__(self):
        return '[{}, {}, {}]'.format(self.x, self.y, self.z)


class Beacon(models.Model):
    """
    Beacon model.
    Used in the implementation of direction maps.
    """
    location = models.ForeignKey(Location, on_delete=models.PROTECT)
    isActive = models.BooleanField()

    def __str__(self):
        return '[{},{}]'.format(self.id, self.isActive)


class Tag(models.Model):
    """
    Tag model.
    Used as an interest category for events.
    """
    name = models.CharField(max_length=30)

    def __str__(self):
        return '{}'.format(self.name)


class Room(models.Model):
    """
    Room model.
    Used as the location of events.
    """
    name = models.CharField(max_length=30)
    bealocation = models.ManyToManyField(Beacon) # geolocation of beacons

    def __str__(self):
        return '{}'.format(self.name)


class Event(models.Model):
    """
    Event model.
    """
    name = models.CharField(max_length=30)
    description = models.TextField()
    tag = models.ForeignKey(Tag, on_delete=models.PROTECT)
    room = models.ForeignKey(Room, on_delete=models.PROTECT)
    start_time = models.DateTimeField()
    end_time = models.DateTimeField()
    updates = models.TextField(null=True, blank=True, default=None)

    def __str__(self):
        return '{}'.format(self.name)


class Notification(models.Model):
    """
    Notification model.
    Used to mobile notifications.
    """
    name = models.CharField(max_length=30)
    description = models.TextField()

    def __str__(self):
        return '{}'.format(self.name)