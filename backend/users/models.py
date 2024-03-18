from django.db import models
from django.contrib.auth.models import AbstractUser

class UserData(AbstractUser):
    phonenumber = models.CharField(max_length=20)
    address = models.CharField(max_length=50)

    class Meta:
        default_related_name = 'user_permissions_data'

    # Define related name for user_permissions
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        verbose_name='user permissions',
        blank=True,
        related_name='user_permissions_data',
        related_query_name='user_data',
    )
    groups = models.ManyToManyField(
        'auth.Group',
        verbose_name='groups',
        blank=True,
        related_name='user_groups_data',
        related_query_name='user_data',
    )

    def __str__(self):
        return self.username

class DriverData(AbstractUser):
    phonenumber = models.CharField(max_length=20)
    address = models.CharField(max_length=50)
    licensenum = models.CharField(max_length=30)
    citizenshipphoto = models.ImageField(upload_to='citizenship_photos/')
    licensephoto = models.ImageField(upload_to='license_photos/')

    class Meta:
        default_related_name = 'user_permissions_driver'
    groups = models.ManyToManyField(
        'auth.Group',
        verbose_name='groups',
        blank=True,
        related_name='user_groups_driver',
        related_query_name='driver_data',
    )
    # Define related name for user_permissions
    user_permissions = models.ManyToManyField(
        'auth.Permission',
        verbose_name='user permissions',
        blank=True,
        related_name='user_permissions_driver',
        related_query_name='driver_data',
    )
    

    def __str__(self):
        return self.username
