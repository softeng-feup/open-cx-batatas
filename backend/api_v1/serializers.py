"""
Serializers for api_v1.
"""
from rest_framework import serializers
from core.models import Location
from core.models import Tag
from core.models import Event
from core.models import Notification
from core.models import Place
from core.models import Beacon

class LocationSerializer(serializers.ModelSerializer):
    """
    Location serializer.
    """
    class Meta:
        model = Location
        fields = ['latitude', 'longitude', 'floor']


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


class PlaceSerializer(serializers.ModelSerializer):
    """
    Place serializer.
    """
    location = LocationSerializer()

    class Meta:
        model = Place
        fields = ['name', 'place_type', 'location']


class BeaconSerializer(serializers.ModelSerializer):
    """
    Beacon serializer.
    """
    location = LocationSerializer()

    class Meta:
        model = Beacon
        fields = ['id', 'mac_address', 'is_active', 'location']
