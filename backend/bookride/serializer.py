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
    ride = RideRequestedSerializer(many=False, read_only=True)
    username=serializers.SerializerMethodField()
    pickup = serializers.CharField(source='ride.pickup')
    drop = serializers.CharField(source='ride.drop')
    distance = serializers.FloatField(source='ride.distance')
    fare = serializers.FloatField(source='ride.fare')
    

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
    def get_username(self, obj):
        return obj.user.username
    def get_drivername(self, obj):
        return obj.driver.username
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
        