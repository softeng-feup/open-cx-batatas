from django.shortcuts import render
from rest_framework import generics, mixins
from .serializers import LocationSerializer
from core.models import Location

# Create your views here.

class LocationList(mixins.ListModelMixin,
                   mixins.CreateModelMixin,
                   generics.GenericAPIView):

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
