import'package:flutter/material.dart';
class destinationpage extends StatefulWidget {
  const destinationpage({super.key});

  @override
  State<destinationpage> createState() => _destinationpageState();
}

class _destinationpageState extends State<destinationpage> {
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
                labelText: 'Enter your destination here',
              ),
              ),  
              ]),
              )
              
    );
  }
}