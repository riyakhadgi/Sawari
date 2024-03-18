import 'package:flutter/material.dart' show BuildContext, MaterialApp, StatelessWidget, Widget, runApp;
import 'package:flutter/src/widgets/container.dart';
import 'package:user/pages/dashboard.dart';
import 'package:user/pages/loginpage.dart';
import 'package:user/pages/splashscreen.dart';
import 'package:user/pages/pickuppage.dart';

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
      home: LoginPage(),
    );
    
  }
}

