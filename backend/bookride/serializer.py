from rest_framework import serializers
from .models import *

class RideRequestedSerializer(serializers.ModelSerializer):
    class Meta:
        model=RideRequested
        fields='__all__'

class AcceptedRideSerializer(serializers.ModelSerializer):
    class Meta:
        model=AcceptedRide
        fields='__all__'

class CanceledRideSerializer(serializers.ModelSerializer):
    class Meta:
        model=CanceledRide
        fields='__all__'