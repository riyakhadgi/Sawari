import'package:flutter/material.dart';
class saftey extends StatelessWidget {
  const saftey({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        actions: [Text("Saftey")],
      ),
      body: Container(child:Column(children: [
      TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Saftey Tips'),
      ),
       TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {
              
            },
            child: const Text('Call Police'),
      ),
       TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Call Ambulance'),
      )
      ],),),
    );
  }
}