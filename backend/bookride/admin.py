from django.contrib import admin
from .models import *
# Register your models here.
admin.site.register(RideRequested)
admin.site.register(AcceptedRide)
admin.site.register(Prebooking)
admin.site.register(Acceptedprebooking)
