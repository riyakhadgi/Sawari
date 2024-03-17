import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';


class splashscreen extends StatelessWidget {
  const splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body:Container(child:Column(children: [SvgPicture.asset('logo/logo.svg',width: 500, height: 500,)]))
    );
  }
}
