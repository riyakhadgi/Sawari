import 'package:driver/Components/Dashboard.dart';
import 'package:driver/Components/LoginPage.dart';
import 'package:driver/Components/Prebooking.dart';
import 'package:driver/Components/Profile.dart';
import 'package:driver/Components/SplashScreen.dart';
import 'package:driver/Components/safetytips.dart';
import 'package:driver/Components/sendEmail.dart';
import 'package:driver/Components/updatePassword.dart';
import 'package:driver/Components/verifyOtp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
        routes:{
          '/dashboard':(context)=>  Dashboard(),
          '/safetytips':(context)=> safteytips(),
          '/profile':(context)=> profile(),
          '/sendEmail':(context)=> const sendEmail(),
          '/verifyOtp':(context)=> const  verifyOtp(),
          '/updatepassword': (context)=> const  updatePassword(),
          '/prebooking': (context)=> const Prebooking(),
        }
    );
  }
}



