from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

from core.models import Location

# Create your views here.

def hello(request):
    template = loader.get_template('frontend_example/index.html')

    locations = Location.objects.all()

    context = {
        'locations': locations
    }
    return HttpResponse(template.render(context, request))


