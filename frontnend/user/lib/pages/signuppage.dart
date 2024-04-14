import'package:flutter/material.dart';

class signuppage extends StatelessWidget {
  const signuppage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:IconButton(onPressed: (){}, icon:  const Icon(Icons.arrow_back), )),
      body: Container(child: (Column( children: [ 
        const Text("Create account"),
        const Text("Enter your email:"),
         const TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your email here',
         ),
        ),
        const Text("Create Password:"),
         const TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Type your password here',
         ),
        ),
        const Text("Confirm Password:"),
         const TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Retype your password',
         ),
        ),
        ElevatedButton(onPressed: (){}, child: const Text("Create"))
        ],)),),
    );
  }
}