import 'package:flutter/material.dart';
class loginpage extends StatelessWidget {
  const loginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:IconButton(onPressed: (){}, icon:  Icon(Icons.arrow_back), )),
      body: Container(child:(Column(children: [
        Text("Enter your email:"),
        TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your email here',
        ),
        ),
        Text("Enter your password:"),
         TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your password here',
        ),
        ),
        ElevatedButton(onPressed: (){}, child:Text("Continue")),
        ],))),
    );
  }
}