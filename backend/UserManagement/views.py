from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.hashers import check_password,make_password
from django.core.serializers.json import DjangoJSONEncoder
import json
from .models import *
from .serializer import *
import jwt
import random
import string
from django.core.mail import send_mail
from django.conf import settings
from .utils import saveotp


@csrf_exempt
def passenger_login(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            username = data.get('username')
            password = data.get('password')
            print(username)
            print(password)
            user=passengerUser.objects.get(username=username)
            response=PassengerUserSerailizer(user)
           
            if check_password(password,user.password):
                return JsonResponse({"success": True, "message": "Login successful.", "data": response.data})
            else:
                return JsonResponse({"success": False, "message": "Invalid username or password."})
        except json.JSONDecodeError:
            return JsonResponse({"success": False, "message": "Invalid JSON data."})
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."})

    
@csrf_exempt
def passenger_signup(request):
    if request.method == "POST":
        data_json=json.loads(request.body)
        print(data_json)
        serializer=PassengerUserSerailizer(data=data_json)
        if serializer.is_valid():
            user=serializer.save()
            user.password = make_password(data_json['password'])
            user.save()
            return JsonResponse({"success": True, "message": "Signed up"})
        else:
            return JsonResponse({"sucess": False, "message": serializer.errors})
    return  JsonResponse({"sucess": False, "message": "The request should be POST"})

@csrf_exempt
def adminlogin(request):
    if request.method == 'POST':
        data_json = json.loads(request.body)
        username= data_json.get("username")
        password = data_json.get("password")
       
        try:
            user=adminUser.objects.get(username=username)
            print(check_password(password,user.password))
            if check_password(password,user.password):
                serialized=AdminUserSerializer(user,many=False)
               
                payload = {"data": serialized.data}
                token = jwt.encode(payload, "secret", algorithm="HS256")
                print(username)
                return JsonResponse({"success": True, "message": token}, encoder=DjangoJSONEncoder)
            else :  
                return JsonResponse({"success": False, "message": "Invalid username or password."} )
        except Exception as e:
            return JsonResponse({"success": False, "message": "Invalid username or password."})
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."})
    
@csrf_exempt
def adminsignup(request):
    if request.method == "POST":
        data_json = json.loads(request.body)
        print(data_json)
        serializer = AdminUserSerializer(data=data_json)
        if serializer.is_valid():
            random_password = ''.join(random.choices(string.ascii_letters + string.digits, k=12))
            hased_password = make_password(random_password)           
            serializer.validated_data['password'] = hased_password
            print(random_password,hased_password)
            user=serializer.save()
            subject = 'Creation of Account'
            message = f'Welcome {user.name},\nYou can use your email: {user.email} and password:{random_password} for login. We encourage to change the password at first. Welcome to our team.'            
            from_email = settings.EMAIL_HOST_USER
            recipient_list = [user.email]
        # Send the email using Gmail
            send_mail(subject, message, from_email,recipient_list, fail_silently=True)
            return JsonResponse({"success": True, "message": "Signed up successfully."})
        else:
            return JsonResponse({"success": False, "message": serializer.errors})  
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."}, status=405)
    


@csrf_exempt
def driver_login(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            username = data.get('username')
            password = data.get('password')
            print(username)
            print(password)
            user=driverUser.objects.get(username=username)
            print(user)
            response=DriverUserSerializer(user)
            if check_password(password,user.password):
                return JsonResponse({"success": True, "message": "Login successful.", "data": response.data})
            else:
                return JsonResponse({"success": False, "message": "Invalid username or password."})
        except Exception as e:
            return JsonResponse({"success": False, "message": "No user found with the provided username."})
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."})

    
@csrf_exempt
def driver_signup(request):
    if request.method == "POST":
        data_json=json.loads(request.body)
        print(data_json)
        serializer=DriverUserSerializer(data=data_json)
        if serializer.is_valid():
            user=serializer.save()
            user.password = make_password(data_json['password'])
            user.save()
            return JsonResponse({"sucess": True, "message": "Signed up"})
        else:
            return JsonResponse({"sucess": False, "message": serializer.errors})
    return  JsonResponse({"sucess": False, "message": "The request should be POST"})

@csrf_exempt
def editpassengerdata(request,id):
    if request.method =="PUT":
        data=json.loads(request.body)
        print(data)
        name=data.get('name')
        address=data.get('address')
        phonenumber=data.get('phone')
        user=passengerUser.objects.get(id=id)
        user.name=name
        user.address=address
        user.phonenumber=phonenumber
        user.save()
        response=PassengerUserSerailizer(user)
        return JsonResponse({"success": True, "message": "Data updated successfully.", "data": response.data})
    else:
        return JsonResponse({"success": False, "message": "Only PUT requests are allowed."})


@csrf_exempt 
def verifypassenger(request):
    if request.method == "POST":
        data = json.loads(request.body)
        email = data.get('email')

        # Check if a user with the provided email exists
        users = passengerUser.objects.filter(email=email)
        if users.exists():
            user = users.first()  # Assuming only one user per email
            OTP.objects.filter(email=email, active=True).update(active=False)
            otp = random.randint(1000, 9999)
            subject = 'Verification of Account'
            message = f'Welcome {user.name},\nYour OTP for verification is {otp}.'
            from_email = settings.EMAIL_HOST_USER
            recipient_list = [user.email]
            # Send the email using Gmail
            send_mail(subject, message, from_email, recipient_list, fail_silently=True)
            # Save OTP to the database
            if saveotp(email, otp):
                request.session['email'] = email
                request.session['otp'] = otp
                return JsonResponse({"success": True, "message": "Email sent."})
            else:
                return JsonResponse({"success": False, "message": "There was an error saving OTP."})
        else:
            return JsonResponse({"success": False, "message": "User does not exist."})
    return JsonResponse({"success": False, "message": "Method should be POST."})

@csrf_exempt
def validate_otp(request):
    if request.method == "POST":
        data = json.loads(request.body)
        email = data.get('email')
        otp = data.get('otp')
        try:
            otp = OTP.objects.get(email=email, otp=otp, active=True)
            otp.active = False
            otp.save()
            return JsonResponse({"success": True, "message": "OTP validated."})
        except Exception as e:
            return JsonResponse({"success": False, "message": "Invalid OTP."})

@csrf_exempt
def updatepasswordpassenger(request):
    if request.method == "POST":
        data = json.loads(request.body)
        email = data.get('email')
        password = data.get('password')
        try:
            user = passengerUser.objects.get(email=email)
            user.password = make_password(password)
            user.save()
            return JsonResponse({"success": True, "message": "Password updated."})
        except Exception as e:
            return JsonResponse({"success": False, "message": "User does not exist."})


@csrf_exempt 
def verifydriver(request):
    if request.method == "POST":
        data = json.loads(request.body)
        email = data.get('email')

        # Check if a user with the provided email exists
        users = driverUser.objects.filter(email=email)
        if users.exists():
            user = users.first()  # Assuming only one user per email
            OTP.objects.filter(email=email, active=True).update(active=False)
            otp = random.randint(1000, 9999)
            subject = 'Verification of Account'
            message = f'Welcome {user.name},\nYour OTP for verification is {otp}.'
            from_email = settings.EMAIL_HOST_USER
            recipient_list = [user.email]
            # Send the email using Gmail
            send_mail(subject, message, from_email, recipient_list, fail_silently=True)
            # Save OTP to the database
            if saveotp(email, otp):
                request.session['email'] = email
                request.session['otp'] = otp
                return JsonResponse({"success": True, "message": "Email sent."})
            else:
                return JsonResponse({"success": False, "message": "There was an error saving OTP."})
        else:
            return JsonResponse({"success": False, "message": "User does not exist."})
    return JsonResponse({"success": False, "message": "Method should be POST."})

@csrf_exempt
def updatepassworddriver(request):
    if request.method == "POST":
        data = json.loads(request.body)
        email = data.get('email')
        password = data.get('password')
        try:
            user = driverUser.objects.get(email=email)
            user.password = make_password(password)
            user.save()
            return JsonResponse({"success": True, "message": "Password updated."})
        except Exception as e:
            return JsonResponse({"success": False, "message": "User does not exist."})