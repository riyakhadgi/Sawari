import'package:flutter/material.dart';
class pickuppage extends StatefulWidget {
  const pickuppage({super.key});

  @override
  State<pickuppage> createState() => _pickuppageState();
}

class _pickuppageState extends State<pickuppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar( 
       leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        actions: [IconButton(
          onPressed: () {},
          icon: Icon(Icons.close),
        ),],
        ),
        body: Container(child: Column(children:[
         TextField(decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your pickup location here',
              ),
              ),  
              ]),
              )
              
    );
  }
}