from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import *
from django.contrib.auth.hashers import make_password
from .serializer import *
import json
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.hashers import check_password,make_password
from .models import *

@csrf_exempt
def login(request):
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
def signup(request):
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
