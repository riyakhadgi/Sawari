import 'package:driver/Components/Dashboard.dart';
import 'package:driver/Components/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    requestLocationPermission();
    _navigateAfterDelay();
  }
  void requestLocationPermission() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      // Permission granted, proceed with location-related tasks
    } else if (status.isDenied) {
      // Permission denied
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, open app settings
      openAppSettings();
    }
  }
  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    bool userDataExists = await checkUserDataExists();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
        userDataExists ?  Dashboard() : const LoginPage(),
      ),
    );
  }
  Future<bool> checkUserDataExists() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('id') && prefs.containsKey('name');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            SvgPicture.asset('logo/logo.svg', width: 500, height: 500),
          ],
        ),
      ),
    );
  }
}
