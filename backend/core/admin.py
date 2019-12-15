"""
Admin registrations.
"""
from django.contrib import admin
from .models import User, Event, Location,\
                    Tag, Beacon, Notification,\
                    Place, Bookmarks, MapEdge

# Register your models here.

admin.site.register(Beacon)
admin.site.register(Bookmarks)
admin.site.register(Event)
admin.site.register(Location)
admin.site.register(MapEdge)
admin.site.register(Notification)
admin.site.register(Place)
admin.site.register(Tag)
admin.site.register(User)
