import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/pages/dashboard.dart';
import 'package:user/pages/loginpage.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});



  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(seconds: 5));
    bool userDataExists = await checkUserDataExists();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
        userDataExists ? const Dashboard() : const LoginPage(),
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
