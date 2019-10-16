from rest_framework import serializers
from core.models import Location

class LocationSerializer(serializers.ModelSerializer):
    class Meta:
        model = Location
        fields = ['x', 'y', 'z']
