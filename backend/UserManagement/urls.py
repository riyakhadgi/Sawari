
from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path('',passenger_login, name="passenger_login"),
    path('signup/',passenger_signup,name="passenger_login"),
    path('editpassengerdata/<int:id>/',editpassengerdata,name='editpassengerdata'),
    path('verifypassenger/',verifypassenger,name='verifypassenger'),
    path('verifyotp/',validate_otp,name='validate_otp'),
    path('updatepasswordpassenger/',updatepasswordpassenger,name='updatepasswordpassenger'),

    path('adminlogin/',adminlogin,name="adminlogin"),
    path('adminsignup/',adminsignup,name='adminsignup'),



    path('driverlogin/',driver_login,name='driver_login'),
    path('driversignup/',driver_signup,name='driver_signup'),
    path('verifydriver/',verifydriver,name='verifydriver'),
    path('updatepassworddriver/',updatepassworddriver,name='updatepassworddriver'),
    path('document/',uploaddocument,name='uploaddocument'),
]
