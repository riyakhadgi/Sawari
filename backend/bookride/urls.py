from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path('addtemp/',addRide, name="addTempRide"),
    path("getallrides/",getRideAdmin, name="getallrides")
]
