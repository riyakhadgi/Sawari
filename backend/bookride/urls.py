from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path('addtemp/',addRide, name="addTempRide"),
    path('gettemp/',getRide, name="getTempRide"),
    path("getallrides/",getRideAdmin, name="getallrides"),
    path('getridehistory/<int:id>/',getridehistory,name='getridehistory'),


    path('addprebooking/',addprebooking, name="addprebooking"),
    path('getprebooking/',getprebooking, name="getprebooking"),
]
