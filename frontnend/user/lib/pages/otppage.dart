import 'package:flutter/material.dart';

class otppage extends StatelessWidget {
  const otppage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_back), )),
      body: Container(child:Column(children: [
        Text("OTP Verification"),
        TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'OTP',
        ),
        ),
        ElevatedButton(onPressed: (){}, child: Text("VERIFY"))
        ],))

    );
  }
}