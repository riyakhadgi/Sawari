from rest_framework import serializers
from .models import *

class UserDataSerializer(serializers.ModelSerializer):
    class Meta:
        model=UserData
        fields= '__all__'

    def to_representation(self, instance):
        data=super().to_representation(instance)
        data.pop('password', None)
        return data
    
class DriverDataSerializer(serializers.ModelSerializer):
    class Meta:
        model=DriverData
        fields='__all__'

    def to_representation(self, instance):
        data=super().to_representation(instance)
        data.pop('password', None)
        return data