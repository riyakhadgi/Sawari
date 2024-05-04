import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;
import 'package:user/pages/dashboard.dart';
import 'package:user/pages/loginpage.dart';
import 'package:user/pages/prebooking.dart';
import 'package:user/pages/profile.dart';
import 'package:user/pages/requesthistory.dart';
import 'package:user/pages/safteytips.dart';
import 'package:user/pages/sendEmail.dart';
import 'package:user/pages/splashscreen.dart';
import 'package:user/pages/updatePassword.dart';
import 'package:user/pages/verifyOtp.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes:{
          '/login':(context)=> const LoginPage(),
          '/dashboard':(context)=> const Dashboard(),
          '/safetytips':(context)=>const safteytips(),
          '/profile':(context)=>const profile(),
          '/prebooking':(context)=>const PreBooking(),
          '/requesthistory':(context)=>const requesthistory(),
          '/sendEmail':(context)=> const sendEmail(),
          '/verifyOtp':(context)=> const  verifyOtp(),
          '/updatepassword': (context)=> const  updatePassword(),
        }
    );

  }
}

