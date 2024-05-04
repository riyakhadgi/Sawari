import 'package:driver/Components/Dashboard.dart';
import 'package:driver/Components/Profile.dart';
import 'package:driver/Components/SplashScreen.dart';
import 'package:driver/Components/listen.dart';
import 'package:driver/Components/safetytips.dart';
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
      home: Dashboard(),
        routes:{
          '/dashboard':(context)=>  Dashboard(),
          '/safetytips':(context)=> safteytips(),
          '/profile':(context)=> profile(),
        }
    );
  }
}



