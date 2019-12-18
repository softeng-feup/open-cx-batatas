"""
Views for api_v1.
"""
from rest_framework import generics, mixins
from rest_framework import status
from rest_framework.permissions import IsAuthenticated
from rest_framework.authtoken.models import Token
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.decorators import api_view
from core.models import Location, Tag,\
                        Notification, Place,\
                        Event, Beacon, MapEdge,\
                        User
from .serializers import LocationSerializer, TagSerializer,\
                         EventSerializer, NotificationSerializer,\
                         PlaceSerializer, BeaconSerializer,\
                         MapEdgeSerializer, UserSignUpSerializer,\
                         UserSignInSerializer, UserProfileSerializer

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

class PlaceList(mixins.ListModelMixin,
                generics.GenericAPIView):
    """
    Lists all places.
    """
    queryset = Place.objects.all()
    serializer_class = PlaceSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the places.
        """
        return self.list(request, *args, **kwargs)

class UserList(mixins.ListModelMixin,
               generics.GenericAPIView):
    """
    Lists all places.
    """
    queryset = User.objects.all()
    serializer_class = UserProfileSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the places.
        """
        return self.list(request, *args, **kwargs)

class MapEdgeList(mixins.ListModelMixin,
                  generics.GenericAPIView):
    """
    Lists all map edges.
    """
    queryset = MapEdge.objects.all()
    serializer_class = MapEdgeSerializer

    def get(self, request, *args, **kwargs):
        """
        Handler for GET requests.

        Lists all the edges.
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

        Lists all the places.
        """
        return self.list(request, *args, **kwargs)

@api_view(['POST'])
def sign_up(request):
    """
    Creates a new user account.
    """
    serializer = UserSignUpSerializer(data=request.data)
    if serializer.is_valid():
        new_user = serializer.save()
        token = Token.objects.create(user=new_user)
        return Response({'token': token.key}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
def sign_in(request):
    """
    Signs in a user.
    """
    serializer = UserSignInSerializer(data=request.data)
    if serializer.is_valid():
        user = serializer.save()
        if Token.objects.filter(user=user):
            token = Token.objects.get(user=user)
        else:
            token = Token.objects.create(user=user)
        return Response({'token': token.key}, status=status.HTTP_200_OK)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class ProfileDetail(APIView):
    """
    Retrieve and update a user's profile
    information.
    """
    permission_classes = [IsAuthenticated]

    def get(self, request):
        """
        GET request handler.

        Returns a user's profile information.
        """
        serializer = UserProfileSerializer(request.user)
        return Response(serializer.data)

    def put(self, request): # pylint: disable=no-self-use
        """
        PUT request handler.

        Updates a user's profile information and returns
        the newly updated information.
        """
        serializer = UserProfileSerializer(request.user, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
