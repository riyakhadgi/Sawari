from rest_framework import serializers
from .models import *
from UserManagement.models import *
from UserManagement.serializer import *

class RideRequestedSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()
    phone = serializers.SerializerMethodField()
    def get_username(self, obj):
        return obj.user.username
    def get_phone(self, obj):
        return obj.user.phonenumber
    class Meta:
        model=RideRequested
        fields='__all__'

class AcceptedRideSerializer(serializers.ModelSerializer):
    class Meta:
        model=AcceptedRide
        fields='__all__'
    def get_username(self, obj):
        return obj.ride.user.username
    

class CanceledRideSerializer(serializers.ModelSerializer):
    class Meta:
        model=CanceledRide
        fields='__all__'
    
class PrebookingSerializer(serializers.ModelSerializer):
    username = serializers.SerializerMethodField()
    phone = serializers.SerializerMethodField()
    def get_username(self, obj):
        return obj.user.username
    def get_phone(self, obj):
        return obj.user.phonenumber
    class Meta:
        model=Prebooking
        fields='__all__'

class AcceptedprebookingSerializer(serializers.ModelSerializer):
    class Meta:
        model=Acceptedprebooking
        fields='__all__'

class CancelledprebookingSerializer(serializers.ModelSerializer):
    class Meta:
        model=Cancelledprebooking
        fields='__all__'
        