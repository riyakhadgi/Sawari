from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path('addtemp/',addRide, name="addTempRide"),
    path('gettemp/',getRide, name="getTempRide"),
    path("getallrides/",getRideAdmin, name="getallrides"),
    path('getridehistory/<int:id>/',getridehistory,name='getridehistory'),
    path("acceptride/",acceptRide,name='acceptRide'),
    path("getrideinfo/<int:id>/",getrideinfo,name='getrideinfo'),
    path("endride/<int:id>/",endride,name='endride'),

    path('addprebooking/',addprebooking, name="addprebooking"),
    path('getprebooking/',getprebooking, name="getprebooking"),
    path('acceptprebooking/',acceptprebooking, name="acceptprebooking"),
    path('getdriveraccept/<int:id>/',driveracceptprebook,name='driveracceptprebook'),
    path("endprebook/<int:id>/",endprebook,name='endprebook'),

    #admin
    path('showprebooking/',showprebooking,name='showprebooking')
]
