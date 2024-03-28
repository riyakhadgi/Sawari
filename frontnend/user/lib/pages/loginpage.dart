import 'package:flutter/material.dart';
import 'package:user/Controller/UserController.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserController user = UserController();

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

                // Perform authentication logic here
                // For example:
                 user.login(username, password);
                print(user.isAuth);
            
                if (user.isAuth) {
                  // Navigate to the dashboard page
                  Navigator.pushReplacementNamed(context, '/dashboard');
                } else {
                  // Handle authentication failure, e.g., display an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Invalid username or password'),
                    ),
                  );
                }
              },
              child: Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
}
