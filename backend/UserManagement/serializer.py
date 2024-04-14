from rest_framework import serializers
from .models import *

class AdminUserSerializer(serializers.ModelSerializer):
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
    
class DriverUserSerializer(serializers.ModelSerializer):
    class Meta:
        model=driverUser
        fields='__all__'

    def to_representation(self, instance):
        data=super().to_representation(instance)
        data.pop('password', None)
        return data