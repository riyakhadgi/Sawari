import'package:flutter/material.dart'; 
class requesthistory extends StatelessWidget {
  const requesthistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
        actions: [Text("My Rides")],
      ),
    );
  }
}