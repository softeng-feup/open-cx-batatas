# Generated by Django 2.2.6 on 2019-12-09 22:05

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='beacon',
            name='mac_address',
            field=models.CharField(default='', max_length=17),
            preserve_default=False,
        ),
    ]
