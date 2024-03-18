from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import *
from django.contrib.auth.hashers import make_password
from .serializer import *
from django.contrib.auth import authenticate

@csrf_exempt
from django.contrib.auth import authenticate, login as auth_login
import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt

@csrf_exempt
def login(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            print(data)
            username = data.get('username')
            password = data.get('password')
            user = authenticate(username=username, password=password)
            print(user)
            if user is not None:
                auth_login(request, user)  # Renamed login function to auth_login
                return JsonResponse({"success": True, "message": "Works"})
            else:
                return JsonResponse({"success": False, "message": "Authentication failed"})
            
         
        except json.JSONDecodeError:
            return JsonResponse({"success": False, "message": "Invalid JSON data."}, status=400)
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."}, status=405)

    
@csrf_exempt
def signup(request):
    if request.method == "POST":
        data=json.loads(request.body)
        serializer=UserDataSerializer(data=data)
        if serializer.is_valid():

            user=serializer.save()
            user.password = make_password(data['password'])
            user.save()
            return JsonResponse({"sucess": True, "message": "Signed up"})
        else:
            return JsonResponse({"sucess": False, "message": serializer.errors})
    return  JsonResponse({"sucess": False, "message": "The request should be POST"})
