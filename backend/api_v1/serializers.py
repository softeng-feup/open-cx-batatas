"""
Serializers for api_v1.
"""
from datetime import date
from django.contrib.auth import password_validation, authenticate
from rest_framework import serializers
from core.validators import has_special_chars
from core.models import Location, Tag, Event,\
                        Notification, Place, Beacon,\
                        User

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
        fields = ['id', 'name']


class EventSerializer(serializers.ModelSerializer):
    """
    Event serializer.
    """
    class Meta:
        model = Event
        fields = ['id', 'name', 'description', 'start_time', 'end_time', 'updates']


class NotificationSerializer(serializers.ModelSerializer):
    """
    Notification serializer.
    """
    class Meta:
        model = Notification
        fields = ['id', 'name', 'description']


class PlaceSerializer(serializers.ModelSerializer):
    """
    Place serializer.
    """
    location = LocationSerializer()

    class Meta:
        model = Place
        fields = ['id', 'name', 'place_type', 'location']


class MapEdgeSerializer(serializers.ModelSerializer):
    """
    MapEdge serializer.
    """
    vertex1 = PlaceSerializer()
    vertex2 = PlaceSerializer()

    class Meta:
        model = Tag
        fields = ['id', 'vertex1', 'vertex2']


class BeaconSerializer(serializers.ModelSerializer):
    """
    Beacon serializer.
    """
    location = LocationSerializer()

    class Meta:
        model = Beacon
        fields = ['id', 'mac_address', 'is_active', 'location']


class UserSignUpSerializer(serializers.ModelSerializer):
    """
    Serializer for creating new users.
    """
    class Meta:
        model = User
        fields = ('email', 'first_name', 'last_name', 'username', 'date_of_birth', 'password')

    def create(self, validated_data):
        new_user = User(**validated_data)
        new_user.set_password(self.validated_data['password'])
        new_user.save()
        return new_user

    def validate_first_name(self, value): # pylint: disable=no-self-use
        """
        Capitalizes the first_name
        """
        if has_special_chars(value):
            raise serializers.ValidationError('No spaces, numbers and special characters allowed.') # pylint: disable=line-too-long
        return value.strip().title()

    def validate_last_name(self, value): # pylint: disable=no-self-use
        """
        Capitalizes the last_name
        """
        if has_special_chars(value):
            raise serializers.ValidationError('No spaces, numbers and special characters allowed.') # pylint: disable=line-too-long
        return value.strip().title()

    def validate_date_of_birth(self, value): # pylint: disable=no-self-use
        """
        Validates if date_of_birth was
        more that 13 years ago.
        """
        today = date.today()
        age = today.year - value.year - ((today.month, today.day) < (value.month, value.day))
        if age < 13:
            raise serializers.ValidationError('You must be at least 13 to create an account.')
        return value

    def validate_password(self, value):
        """
        Validate password using default password validators.
        """
        password_validation.validate_password(value, self.instance)
        return value


class UserSignInSerializer(serializers.Serializer):
    """
    Serializer for signing users in.
    """
    email = serializers.EmailField(write_only=True)
    password = serializers.CharField(max_length=128, write_only=True)

    def create(self, validated_data):
        user = authenticate(username=validated_data['email'], password=validated_data['password'])
        return user

    def update(self, instance, validated_data):
        return instance

    def validate(self, attrs):
        """
        Checks if credentials are correct.
        """
        user = authenticate(username=attrs['email'], password=attrs['password'])
        if user is None:
            raise serializers.ValidationError('Email or password incorrect.')
        return attrs


class UserProfileSerializer(serializers.ModelSerializer):
    """
    Serializer for User.
    """
    full_name = serializers.SerializerMethodField()

    class Meta:
        model = User
        fields = ['full_name', 'first_name', 'last_name', 'position', 'company', 'is_speaker']
        read_only_fields = ['is_speaker']

    def get_full_name(self, obj): # pylint: disable=no-self-use
        """
        Returns user's 'first_name last_name'
        """
        return obj.get_full_name()
