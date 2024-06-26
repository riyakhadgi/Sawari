# Generated by Django 5.0.2 on 2024-05-04 10:56

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('UserManagement', '0002_driveruser_isactive_driverdocuments'),
        ('bookride', '0005_remove_cancelledprebooking_prebooking_and_more'),
    ]

    operations = [
        migrations.CreateModel(
            name='Acceptedprebooking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('driver', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='UserManagement.driveruser')),
            ],
        ),
        migrations.CreateModel(
            name='Prebooking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('pickup', models.CharField(max_length=100)),
                ('drop', models.CharField(max_length=100)),
                ('distance', models.FloatField()),
                ('fare', models.FloatField()),
                ('datetime', models.DateTimeField()),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('status', models.CharField(default='requested', max_length=50)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='UserManagement.passengeruser')),
            ],
        ),
        migrations.CreateModel(
            name='Cancelledprebooking',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('canceledby', models.CharField(max_length=50)),
                ('canceledreaseon', models.CharField(max_length=100)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('prebooking', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='bookride.prebooking')),
            ],
        ),
    ]
