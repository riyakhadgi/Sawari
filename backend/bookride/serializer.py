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
    username = serializers.SerializerMethodField()
    pickup = serializers.SerializerMethodField()
    drop = serializers.SerializerMethodField()
    distance = serializers.SerializerMethodField()
    fare = serializers.SerializerMethodField()
    class Meta:
        model=AcceptedRide
        fields='__all__'
    def get_username(self, obj):
        return obj.ride.user.username
    def get_pickup(self, obj):
        return obj.ride.pickup
    def get_drop(self, obj):
        return obj.ride.drop
    def get_distance(self, obj):
        return obj.ride.distance
    def get_fare(self, obj):
        return obj.ride.fare
    
    

    
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

        