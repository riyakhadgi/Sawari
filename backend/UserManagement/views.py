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
                return JsonResponse({"success": False, "message": "Invalid username or password."}, status=401)
        except json.JSONDecodeError:
            return JsonResponse({"success": False, "message": "Invalid JSON data."}, status=400)
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."}, status=405)

    
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
            return JsonResponse({"sucess": True, "message": "Signed up"})
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
            if check_password(password,user.password):
                serialized=AdminUserSerializer(user,many=False)
                payload = {"data": serialized.data}
                token = jwt.encode(payload, "secret", algorithm="HS256")
                return JsonResponse({"success": True, "message": token}, encoder=DjangoJSONEncoder)
            else :  
                return JsonResponse({"success": False, "message": "Invalid username or password."}, status=401)
        except Exception as e:
            return JsonResponse({"success": False, "message": "Invalid username or password."}, status=401)
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."}, status=405)
    
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