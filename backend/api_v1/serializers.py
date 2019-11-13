"""
Serializers for api_v1.
"""
from rest_framework import serializers
from core.models import Location
from core.models import Tag
from core.models import Event
from core.models import Notification
from core.models import Room
from core.models import Beacon

class LocationSerializer(serializers.ModelSerializer):
    """
    Location serializer.
    """
    class Meta:
        model = Location
        fields = ['x', 'y', 'z']


class TagSerializer(serializers.ModelSerializer):
    """
    Tag serializer.
    """
    class Meta:
        model = Tag
        fields = ['name']


class EventSerializer(serializers.ModelSerializer):
    """
    Event serializer.
    """
    class Meta:
        model = Event
        fields = ['name', 'description', 'start_time', 'end_time', 'updates']


class NotificationSerializer(serializers.ModelSerializer):
    """
    Notification serializer.
    """
    class Meta:
        model = Notification
        fields = ['name', 'description']


class RoomSerializer(serializers.ModelSerializer):
    """
    Room serializer.
    """
    class Meta:
        model = Room
        fields = ['name']


class BeaconSerializer(serializers.ModelSerializer):
    """
    Beacon serializer.
    """
    class Meta:
        model = Beacon
        fields = ['id']
