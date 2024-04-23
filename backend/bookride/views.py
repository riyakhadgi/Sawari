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

# this is for admin to get all the rides
@csrf_exempt
def getRideAdmin(request):
    if request.method=='GET':
        rides=RideRequested.objects.all()
        accepted=AcceptedRide.objects.all()
        canceled=CanceledRide.objects.all()

        ride=RideRequestedSerializer(rides,many=True).data
        accept=AcceptedRideSerializer(accepted,many=True).data
        cancel=CanceledRideSerializer(canceled,many=True).data

        context = {
        'ride_requests': ride,
        'accepted_requests': accept,
        'canceled_requests': cancel
        }
        return JsonResponse({'success':True,'data':context})
    return JsonResponse({'success':False,'message':'Method should be GET'})
