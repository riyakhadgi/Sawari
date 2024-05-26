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
from UserManagement.models import passengerUser
# Create your views here.
@csrf_exempt
def addRide(request):
    if request.method=='POST':
        data=json.loads(request.body)
        userId=data['user']
        user=passengerUser.objects.get(id=userId)
        data['username']=user.name
        data['phone']=user.phonenumber
        try:
            serializer=RideRequestedSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                data['id']=serializer.data['id']
                print("dqtq",data   )
                channel_layer = get_channel_layer()
                async_to_sync(channel_layer.group_send)(
                    "notifications_group",
                    {
                        "type": "notify_driver",
                        "message": data,
                    }
                )
                return JsonResponse({'success':True,'message':'Ride Requested'})
            return JsonResponse({'success':False,'message':serializer.errors})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    return JsonResponse({'success':False,'message':'Method should be POST'})

@csrf_exempt
def acceptRide(request):
    if request.method=='POST':
        data=json.loads(request.body)

        print(data)
        try:
            ride=RideRequested.objects.get(id=data['ride'])
            ride.status='accepted'
            ride.save()
            serializer=AcceptedRideSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                user_id = ride.user.id  # Assuming user ID is stored in the 'user' field of RideRequested
                driver_id= data['driver']
                driverobj= driverUser.objects.get(id=driver_id)
                document= driverDocuments.objects.get(driver= driver_id)
                print(driverobj.name,driverobj.phonenumber,document.vehicleModel,document.vehicleNumber)

                data={
                    "name": driverobj.name,
                    "phone": driverobj.phonenumber,
                    "vechile": document.vehicleModel,
                    "vechileNumber": document.vehicleNumber,
                }
                print(data  )
                channel_layer = get_channel_layer()
                async_to_sync(channel_layer.group_send)(
                    "notifications_group",  # Sending to the specific user's channel
                    {
                        "type": "notify_user",
                        "message": data
                    },
                )
                return JsonResponse({'success':True,'message':'Ride Accepted'})
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
            serializer1=AcceptedRideSerializer(acceptedrides,many=True)
            return JsonResponse({'success':True,'accepted':serializer1.data})
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

        ride=RideRequestedSerializer(rides,many=True).data
        accept=AcceptedRideSerializer(accepted,many=True).data
        context = {
        'ride_requests': ride,
        'accepted_requests': accept,
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

@csrf_exempt
def getprebooking(request):
    if request.method=='GET':
        serializers=Prebooking.objects.filter(status='requested')
        serializer=PrebookingSerializer(serializers,many=True)
        return JsonResponse({'success':True,'data':serializer.data})
    return JsonResponse({'success':False,'message':'Method should be GET'})

@csrf_exempt
def acceptprebooking(request):
    if request.method=='POST':
        data=json.loads(request.body)
        try:
            prebooking=Prebooking.objects.get(id=data['prebooking'])
            prebooking.status='accepted'
            prebooking.save()
            serializer=AcceptedprebookingSerializer(data=data)
            if serializer.is_valid():
                serializer.save()
                return JsonResponse({'success':True,'message':'Prebooking Accepted'})
            return JsonResponse({'success':False,'message':serializer.errors})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    return JsonResponse({'success':False,'message':'Method should be POST'})

@csrf_exempt
def getrideinfo(request,id):
    if request.method=='GET':
        try:
            ride=RideRequested.objects.filter(id=id).first()
            serializer=RideRequestedSerializer(ride)
            return JsonResponse({'success':True,'data':serializer.data})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    else:
        return JsonResponse({'success':False,'message':'Method should be GET'})
    
@csrf_exempt 
def endride(request,id):
    if request.method=='POST':
        try:
            ride=RideRequested.objects.get(id=id)
            print(ride)
            ride.status='completed'
            ride.save()
            return JsonResponse({'success':True,'message':'Ride Completed'})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    else:
        return JsonResponse({'success':False,'message':'Method should be POST'})
    

@csrf_exempt
def driveracceptprebook(request,id):
    if request.method=='GET':
        try:
            print("h")
            accepted=Acceptedprebooking.objects.get(driver=id)
            id=accepted.prebooking.id
            print(id)
            prebooking=Prebooking.objects.get(id=id)
            serializer=PrebookingSerializer(prebooking)
            print(serializer.data)
            return JsonResponse({'success':True,'data':serializer.data})
        except Exception as e:  
            return JsonResponse({'success':False,'message':str(e)})
    else:
        return JsonResponse({'success':False,'message':'Method should be GET'})
    

@csrf_exempt
def endprebook(request,id):
    if request.method=='POST':
        print(id)
        try:
            prebooking=Prebooking.objects.get(id=id)
            prebooking.status='completed'
            prebooking.save()
            return JsonResponse({'success':True,'message':'Prebooking Completed'})
        except Exception as e:
            return JsonResponse({'success':False,'message':str(e)})
    else:
        return JsonResponse({'success':False,'message':'Method should be POST'})
    

#admin
@csrf_exempt
def showprebooking(request):
    if request.method=='GET':
        prebookings=Prebooking.objects.all()
        serializer=PrebookingSerializer(prebookings,many=True)
        return JsonResponse({'success':True,'data':serializer.data})
    return JsonResponse({'success':False,'message':'Method should be GET'})