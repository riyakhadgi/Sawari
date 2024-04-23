from rest_framework import serializers
from .models import *
from UserManagement.serializer import *

class RideRequestedSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()
    def get_username(self, obj):
        return obj.user.username
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