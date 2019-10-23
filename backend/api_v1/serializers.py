from rest_framework import serializers
from core.models import Location
from core.models import Tag

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['x', 'y', 'z']
class TagSerializer(serializers.ModelSerializer):
    class Meta:
        model = Tag
        fields = ['name']