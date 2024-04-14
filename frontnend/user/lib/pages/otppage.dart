import 'package:flutter/material.dart';

class otppage extends StatelessWidget {
  const otppage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:IconButton(onPressed: (){}, icon:  const Icon(Icons.arrow_back), )),
      body: Container(child:Column(children: [
        const Text("OTP Verification"),
        const TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'OTP',
        ),
        ),
        ElevatedButton(onPressed: (){}, child: const Text("VERIFY"))
        ],))

    );
  }
}