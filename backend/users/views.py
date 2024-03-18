from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .models import *
from django.contrib.auth import authenticate

@csrf_exempt
def login(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            print(data)
            username = data.get('username')
            password = data.get('password')
            user= authenticate(username=username,password=password)
            if user is not None:
                login(request, user)
            else:
                print("Authentication failed")
           
            return JsonResponse({"success": True, "message": "Works"})
         
        except json.JSONDecodeError:
            return JsonResponse({"success": False, "message": "Invalid JSON data."}, status=400)
    else:
        return JsonResponse({"success": False, "message": "Only POST requests are allowed."}, status=405)
