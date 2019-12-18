"""
URLs for api_v1.
"""
from django.urls import path
from . import views

urlpatterns = [
    # General models
    path('locations/', views.LocationList.as_view()),
    path('tags/', views.TagList.as_view()),
    path('events/', views.EventList.as_view()),
    path('notifications/', views.NotificationList.as_view()),
    path('places/', views.PlaceList.as_view()),
    path('edges/', views.MapEdgeList.as_view()),
    path('beacons/', views.BeaconList.as_view()),
    path('users/', views.UserList.as_view()),

    # Authentication
    path('auth/login/', views.sign_in),
    path('auth/register/', views.sign_up),
    path('profile/', views.ProfileDetail.as_view()),
]
