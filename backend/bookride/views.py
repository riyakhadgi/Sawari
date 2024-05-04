import json
from django.shortcuts import render
from .models import *
from .serializer import *
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from channels.layers import get_channel_layer
from asgiref.sync import async_to_sync
from datetime import datetime
from django.utils.timezone import make_aware

# Create your views here.
@csrf_exempt
def addRide(request):
    if request.method=='POST':
        data=json.loads(request.body)
        serializer=RideRequestedSerializer(data=data)
        try:
            if serializer.is_valid():
                serializer.save()
                channel_layer = get_channel_layer()
# Inside your Django views or signals
                async_to_sync(channel_layer.group_send)(
                    "notifications_group",
                    {
                        "type": "notify_driver",
                        "message": "New ride request",
                    }
                )
                return JsonResponse({'success':True,'message':'Ride Requested'})
            return JsonResponse({'success':False,'message':serializer.errors})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    return JsonResponse({'success':False,'message':'Method should be POST'})

@csrf_exempt
def getRide(request):
    if request.method=='GET':
        rides=RideRequested.objects.filter(status='requested')
        serializer=RideRequestedSerializer(rides,many=True)
        return JsonResponse({'success':True,'data':serializer.data})
    return JsonResponse({'success':False,'message':'Method should be GET'})

@csrf_exempt
def getridehistory(request,id):
    if request.method=='GET':
        try:
            ride=RideRequested.objects.filter(user=id).first()
            acceptedrides=AcceptedRide.objects.filter(ride=ride).all()
            canceledride=CanceledRide.objects.filter(ride=ride).all()
            serializer1=AcceptedRideSerializer(acceptedrides,many=True)
            serializer2=CanceledRideSerializer(canceledride,many=True)
            return JsonResponse({'success':True,'accepted':serializer1.data,'canceled':serializer2.data})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    else:
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


@csrf_exempt
def addprebooking(request):
    if request.method=='POST':
        data=json.loads(request.body)
        print(data)
        # Convert datetime string to datetime object
        datetime_str = data['datetime']
        datetime_obj = datetime.fromisoformat(datetime_str)
        # Make datetime object aware of timezone
        aware_datetime_obj = make_aware(datetime_obj)
        data['datetime'] = aware_datetime_obj
        serializer=PrebookingSerializer(data=data)
        print("hi")
        try:
            if serializer.is_valid():
                serializer.save()
                return JsonResponse({'success':True,'message':'Prebooking Requested Check later for driver acceptance'})
            return JsonResponse({'success':False,'message':serializer.errors})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    return JsonResponse({'success':False,'message':'Method should be POST'})