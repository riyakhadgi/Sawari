import json
from django.shortcuts import render
from .models import *
from .serializer import *
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

# Create your views here.
@csrf_exempt
#for temporary ride request
def addRide(request):
    if request.method=='POST':
        data=json.loads(request.body)
        print(data)
        serializer=RideRequestedSerializer(data=data)
        print("hi")
        try:
            if serializer.is_valid():
                serializer.save()
                return JsonResponse({'success':True,'message':'Ride Requested'})
            return JsonResponse({'success':False,'message':serializer.errors})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    return JsonResponse({'success':False,'message':'Method should be POST'})

@csrf_exempt
def getRide(request):
    if request.method=='GET':
        rides=RideRequested.objects.all()
        serializer=RideRequestedSerializer(rides,many=True)
        return JsonResponse({'success':True,'data':serializer.data})
    return JsonResponse({'success':False,'message':'Method should be GET'})

