from .serializer import OTPSerializer
from django.http import JsonResponse

def saveotp(email,otp):
    try:
        otp = OTPSerializer(data={"email":email,"otp":otp})
        if otp.is_valid():
            otp.save()
            return True
        else:
            return False
    except Exception as e:
        return False