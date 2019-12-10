"""
Admin registrations.
"""
from django.contrib import admin
from .models import Event, Location, Tag, Beacon, Notification, Place, Bookmarks

# Register your models here.

admin.site.register(Event)
admin.site.register(Location)
admin.site.register(Tag)
admin.site.register(Beacon)
admin.site.register(Notification)
admin.site.register(Place)
admin.site.register(Bookmarks)
