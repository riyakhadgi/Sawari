# Generated by Django 5.0.2 on 2024-05-04 10:57

import django.db.models.deletion
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('bookride', '0006_acceptedprebooking_prebooking_cancelledprebooking'),
    ]

    operations = [
        migrations.AddField(
            model_name='acceptedprebooking',
            name='prebooking',
            field=models.ForeignKey(default=0, on_delete=django.db.models.deletion.CASCADE, to='bookride.prebooking'),
            preserve_default=False,
        ),
    ]
