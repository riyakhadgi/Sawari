import'package:flutter/material.dart';
import 'package:user/Controller/UserController.dart';
import 'package:user/pages/loginpage.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  UserController user= new UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF040444),
        title: Text("Signup",style: TextStyle(color: Colors.white),),
        centerTitle: true,
      ),
      body: body(),
    );
  }
  Widget body(){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF040444),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    style: TextStyle(color: Colors.white),
                    decoration:  InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // Border color when focused
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white, // Border color when not focused
                          ),
                        ),
                        labelText: 'Enter your username here',
                        labelStyle: TextStyle(color: Colors.white)
                    ),
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when focused
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when not focused
                        ),
                      ),
                      labelText: 'Enter your password here',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    obscureText: true, // Hide the password
                  ),
                  SizedBox(height: 10.0),
                  TextField(
                    controller: nameController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when focused
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when not focused
                        ),
                      ),
                      labelText: 'Enter your name here',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  TextField(
                    controller: addressController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when focused
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when not focused
                        ),
                      ),
                      labelText: 'Enter your address here',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  TextField(
                    controller: emailController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when focused
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when not focused
                        ),
                      ),
                      labelText: 'Enter your email here',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.0),

                  TextField(
                    controller: phoneController,
                    style: TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when focused
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white, // Border color when not focused
                        ),
                      ),
                      labelText: 'Enter your phone here',
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () async{
                      // Retrieve the values from the controllers
                      String username = usernameController.text;
                      String password = passwordController.text;
                      String name=nameController.text;
                      String phone=phoneController.text;
                      String address= addressController.text;
                      String email= emailController.text;
                      var data={
                        "username":username,
                        "password":password,
                        "name":name,
                        "phonenumber":phone,
                        "address":address,
                        "email":email,
                      };
                      var response=await user.signup(data);
                      if (response['success']) {
                        var userData=response['data'];
                        Navigator.pushReplacementNamed(context, '/login');
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
            SizedBox(height: 10,),
            Text("Already have an Account?",style: TextStyle(fontSize: 18),),

            TextButton(onPressed: (){
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            }, child: Text("Login",style: TextStyle(fontSize: 24),)),
          ],
        ),
      ),
    );
  }

}