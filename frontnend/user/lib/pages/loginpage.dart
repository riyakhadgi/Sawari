import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/Controller/UserController.dart';
import 'package:user/pages/dashboard.dart';
import 'package:user/pages/signuppage.dart';

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
        backgroundColor: Color(0xFF040444),
        title: Text("Login",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body:SingleChildScrollView(
        child:  Container(
          height: MediaQuery.of(context).size.height*0.89,
          color: Color(0xFF040444),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset('logo/Sawarilogo.svg', width: 150, height: 150,),
              Container(
                child: Column(
                  children: [
                    TextField(
                      controller: usernameController,
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
                          labelText: 'Enter your username here',
                          labelStyle: TextStyle(color: Colors.white)
                      ),
                    ),
                    const SizedBox(height: 20.0),
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
                          labelStyle: TextStyle(color: Colors.white)
                      ),
                      obscureText: true, // Hide the password
                    ),
                    SizedBox(height: 20.0),
                    ElevatedButton(
                      onPressed: () async {
                        String username=usernameController.text;
                        String password=passwordController.text;
                        var r= await user.login(username, password);
                        if(r['success']){
                          print(r['data']);
                          await saveUserDataToSharedPreferences(r['data']);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const Dashboard()),
                          );
                        }
                        else{
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(r['message']),
                                duration: Duration(seconds: 3),
                              ),
                            );
                          });
                        }
                      },
                      child: const Text("Continue"),
                    ),
                    SizedBox(height: 10,),
                    Text("Don't Have an Account?",style: TextStyle(color: Colors.white,fontSize: 18),),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        );
                      },
                      child: Text("Signup",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ],
                ),
              )


            ],
          ),
        ),
      ),

    );
  }
  Future<void> saveUserDataToSharedPreferences(
      Map<String, dynamic> userData) async {
    var prefs = await SharedPreferences.getInstance();
    userData.forEach((key, value) {
      prefs.setString(key, value.toString());
    });
  }
}
