import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/Controller/UserController.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
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
        title: Text("Login"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your username here',
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your password here',
              ),
              obscureText: true, // Hide the password
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async{
                // Retrieve the values from the controllers
                String username = usernameController.text;
                String password = passwordController.text;
                var response=await user.login(username, password);
                if (response['success']) {
                  // store data in shareadprefrences
                  var userData=response['data'];
                  await saveUserData(userData);

                  // Navigate to the dashboard page
                  Navigator.pushReplacementNamed(context, '/dashboard');
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text(response['message']),
                    ),
                  );
                } else {
                  // Handle authentication failure, e.g., display an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                      content: Text(response['message']),
                    ),
                  );
                }
              },
              child: const Text("Continue"),
            ),
          ],
        ),
      ),
    );
  }
  Future<void> saveUserData(Map<String, dynamic> userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    for (var entry in userData.entries) {
      await prefs.setString(entry.key, entry.value.toString());
    }
  }
}
