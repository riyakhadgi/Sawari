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
    isactive=models.BooleanField(default=False,blank=True,null=True)
    
    def _str__(self):
        return self.name
    
class driverDocuments(models.Model):
    driver=models.ForeignKey(driverUser,on_delete=models.CASCADE)
    citizenshipnumber=models.CharField(max_length=50)
    licensenumber=models.CharField(max_length=50)
    vehicleNumber=models.CharField(max_length=50)
    vehicleModel=models.CharField(max_length=50)
    license_front=models.ImageField(upload_to='documents/licensefront/')
    license_back=models.ImageField(upload_to='documents/licenseback/')
    citizenshipnumber_front=models.ImageField(upload_to='documents/citizenshipfront/')
    citizenshipnumber_back=models.ImageField(upload_to='documents/citizenshipback/')
    vehiclepage1=models.ImageField(upload_to='documents/vehiclepage1/')
    vehiclepage2=models.ImageField(upload_to='documents/vehiclepage2/')
    def __str__(self):
        return self.driver.name
    

class OTP(models.Model):
    email=models.EmailField(max_length=254)
    otp=models.CharField(max_length=6)
    active=models.BooleanField(default=True)
    created_at=models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return self.user.name