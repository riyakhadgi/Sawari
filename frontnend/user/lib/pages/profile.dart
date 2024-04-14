import'package:flutter/material.dart';
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: const Icon(Icons.menu),)
      ),
      body: Container(child:Column(children: [
        const TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
        ),),
        const TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Surname',
        ),),
        ElevatedButton(onPressed: (){}, child: const Text("save")),
      ],)),
    );
  }
}