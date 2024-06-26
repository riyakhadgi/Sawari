from rest_framework import serializers
from .models import *

class AdminUserSerializer(serializers.ModelSerializer):
    password = serializers.CharField(required=False)
    class Meta:
        model=adminUser
        fields= '__all__'

    def to_representation(self, instance):
        data=super().to_representation(instance)
        data.pop('password', None)
        return data
    
class PassengerUserSerailizer(serializers.ModelSerializer):
    class Meta:
        model=passengerUser
        fields='__all__'

    def to_representation(self, instance):
        data=super().to_representation(instance)
        data.pop('password', None)
        return data
    
class PassengerDataEditSerializer(serializers.ModelSerializer):
    password = serializers.CharField(required=False)
    class Meta:
        model=passengerUser
        fields='__all__'

class DriverUserSerializer(serializers.ModelSerializer):
    class Meta:
        model=driverUser
        fields='__all__'

    def to_representation(self, instance):
        data=super().to_representation(instance)
        data.pop('password', None)
        return data

class DriverDocumentsSerializer(serializers.ModelSerializer):
    class Meta:
        model=driverDocuments
        fields='__all__'

class OTPSerializer(serializers.ModelSerializer):
    class Meta:
        model=OTP
        fields='__all__'