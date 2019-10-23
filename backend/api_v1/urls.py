from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('locations/', views.LocationList.as_view()),
    path('tags/', views.TagList.as_view()),
    path('events/', views.EventList.as_view()),
    path('notifications/', views.NotificationList.as_view()),
    path('rooms/', views.RoomList.as_view()),
    path('Beacon/', views.BeaconList.as_view()),
]
