import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:user/pages/loginpage.dart';
class SplashScreen extends StatefulWidget {


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
    Navigator.pushReplacement(context, 
    MaterialPageRoute(builder: (context)=> LoginPage()));
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
