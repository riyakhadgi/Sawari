from django.db import models

# Create your models here.
class adminUser(models.Model):
    name=models.CharField(max_length=50)
    username=models.CharField(max_length=50,unique=True)
    address=models.CharField(max_length=100)
    phonenumber=models.CharField(max_length=20)
    email=models.EmailField(max_length=254,unique=True)
    password=models.CharField(max_length=255)

    def __str__(self):
        return self.name

class passengerUser(models.Model):
    name=models.CharField(max_length=50)
    address=models.CharField(max_length=100)
    phonenumber=models.CharField(max_length=20)
    username=models.CharField(max_length=50,unique=True)
    email=models.EmailField(max_length=254,unique=True)
    password=models.CharField(max_length=255)
    
    def _str__(self):
        return self.name

class driverUser(models.Model):
    name=models.CharField(max_length=50)
    address=models.CharField(max_length=100)
    phonenumber=models.CharField(max_length=20)
    username=models.CharField(max_length=50,unique=True)
    email=models.EmailField(max_length=254,unique=True)
    password=models.CharField(max_length=255)
    
    def _str__(self):
        return self.name