"""
Views for api_v1.
"""
from rest_framework import generics, mixins
from core.models import Location, Tag,\
                        Notification, Room,\
                        Event, Beacon
from .serializers import LocationSerializer, TagSerializer,\
                         EventSerializer, NotificationSerializer,\
                         RoomSerializer, BeaconSerializer

class LocationList(mixins.ListModelMixin,
                   mixins.CreateModelMixin,
                   generics.GenericAPIView):
    """
    Lists all locations.
    """
    queryset = Location.objects.all()
    serializer_class = LocationSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the locations.
        """
        return self.list(request, *args, **kwargs)

    def post(self, request, *args, **kwargs):
        """
        Handler for POST requests.

        Creates a new location.
        """
        return self.create(request, *args, **kwargs)


class TagList(mixins.ListModelMixin,
              generics.GenericAPIView):
    """
    Lists all tags.
    """
    queryset = Tag.objects.all()
    serializer_class = TagSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the locations.
        """
        return self.list(request, *args, **kwargs)

class EventList(mixins.ListModelMixin,
                generics.GenericAPIView):
    """
    Lists all events.
    """
    queryset = Event.objects.all()
    serializer_class = EventSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the events.
        """
        return self.list(request, *args, **kwargs)

class NotificationList(mixins.ListModelMixin,
                       generics.GenericAPIView):
    """
    Lists all notifications.
    """
    queryset = Notification.objects.all()
    serializer_class = NotificationSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the notifications.
        """
        return self.list(request, *args, **kwargs)

class RoomList(mixins.ListModelMixin,
               generics.GenericAPIView):
    """
    Lists all rooms.
    """
    queryset = Room.objects.all()
    serializer_class = RoomSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the rooms.
        """
        return self.list(request, *args, **kwargs)

class BeaconList(mixins.ListModelMixin,
                 generics.GenericAPIView):
    """
    Lists all beacons.
    """
    queryset = Beacon.objects.all()
    serializer_class = BeaconSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the rooms.
        """
        return self.list(request, *args, **kwargs)
