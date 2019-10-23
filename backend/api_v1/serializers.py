from rest_framework import serializers
from core.models import Location
from core.models import Tag
from core.models import Event

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['x', 'y', 'z']
class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ['name']
class EventSerializer(serializers.ModelSerializer):
    class Meta:
        model = Event
        fields = ['name', 'description', 'start_time', 'end_time', 'updates']