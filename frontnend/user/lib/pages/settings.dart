import'package:flutter/material.dart';
class settings extends StatelessWidget {
  const settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon:const Icon(Icons.menu)),
        actions: const [Text("Settings")],
       ),
       body: Container(child: Column(children: [
        TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Phone Number'),
      ),
      TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Language'),
      ),
      TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Night Mode'),
      ),
      TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Logout'),
      ),
      TextButton(
        style: TextButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: () {},
            child: const Text('Delete Account'),
      ),
       ],),
       ),
    );
  }
}