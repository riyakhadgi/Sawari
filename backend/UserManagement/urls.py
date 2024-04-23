
from django.contrib import admin
from django.urls import path
from .views import *

urlpatterns = [
    path('',passenger_login, name="passenger_login"),
    path('signup/',passenger_signup,name="passenger_login"),
    path('adminlogin/',adminlogin,name="adminlogin"),
   path('adminsignup/',adminsignup,name='adminsignup'),
]
