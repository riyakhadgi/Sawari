from django.db import models


class RideRequested(models.Model):
    pickup=models.CharField(max_length=100)
    drop=models.CharField(max_length=100)
    distance=models.FloatField()
    fare=models.FloatField()
    user=models.ForeignKey('UserManagement.passengerUser',on_delete=models.CASCADE)
    created_at=models.DateTimeField(auto_now_add=True)
    Status={
        ('requested','requested'),
        ('accepted','accepted'),
        ('canceled','canceled'),
        ('completed','completed')
    }
    status = models.CharField(max_length=50, choices=Status,default='requested')
    def __str__(self):
        return self.pickup

class AcceptedRide(models.Model):
    driver=models.ForeignKey('UserManagement.driverUser',on_delete=models.CASCADE)
    ride=models.ForeignKey(RideRequested,on_delete=models.CASCADE)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now=True)

    def __str__(self):
        return 'Ride request accepted by'+self.driver.name

class CanceledRide(models.Model):
    ride=models.ForeignKey(RideRequested,on_delete=models.CASCADE)
    canceledby=models.CharField(max_length=50)
    canceledreaseon=models.CharField(max_length=100)
    created_at=models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return 'Ride request canceled by'+self.canceledby + 'at' + self.created_at
    
class Prebooking(models.Model):
    pickup=models.CharField(max_length=100)
    drop=models.CharField(max_length=100)
    distance=models.FloatField()
    fare=models.FloatField()
    user=models.ForeignKey('UserManagement.passengerUser',on_delete=models.CASCADE)
    datetime=models.DateTimeField()
    created_at=models.DateTimeField(auto_now_add=True)
    Status={
        ('requested','requested'),
        ('accepted','accepted'),
        ('canceled','canceled'),
        ('completed','completed')
    }
    status = models.CharField(max_length=50, choices=Status,default='requested')
    def __str__(self):
        return self.pickup

class Acceptedprebooking(models.Model):
    driver=models.ForeignKey('UserManagement.driverUser',on_delete=models.CASCADE)
    prebooking=models.ForeignKey(Prebooking,on_delete=models.CASCADE)
    created_at=models.DateTimeField(auto_now_add=True)
    updated_at=models.DateTimeField(auto_now=True)

    def __str__(self):
        return 'Prebooking request accepted by'+self.driver.name + 'for'+self.user.name

class Cancelledprebooking(models.Model):
    prebooking=models.ForeignKey(Prebooking,on_delete=models.CASCADE)
    canceledby=models.CharField(max_length=50)
    canceledreaseon=models.CharField(max_length=100)
    created_at=models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return 'Prebooking request canceled by'+self.canceledby + 'at' + self.created_at