import'package:flutter/material.dart';

class signuppage extends StatelessWidget {
  const signuppage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_back), )),
      body: Container(child: (Column( children: [ 
        Text("Create account"),
        Text("Enter your email:"),
         TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your email here',
         ),
        ),
        Text("Create Password:"),
         TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Type your password here',
         ),
        ),
        Text("Confirm Password:"),
         TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Retype your password',
         ),
        ),
        ElevatedButton(onPressed: (){}, child: Text("Create"))
        ],)),),
    );
  }
}