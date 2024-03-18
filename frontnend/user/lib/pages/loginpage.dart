import 'package:flutter/material.dart';
import 'package:user/Controller/UserController.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserController user = new UserController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username here',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password here',
              ),
              obscureText: true, // Hide the password
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Retrieve the values from the controllers
                String username = usernameController.text;
                String password = passwordController.text;

                // Do something with username and password
                print("Username: $username");
                print("Password: $password");
                user.login(username, password);
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
