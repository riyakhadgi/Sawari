import 'package:driver/Components/Documents.dart';
import 'package:driver/Components/LoginPage.dart';
import 'package:driver/Controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF040444),
        title: Text("Signup",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: body(),
    );

  }

  SingleChildScrollView body(){
    return SingleChildScrollView(
      child:Container(
        height: MediaQuery.of(context).size.height*0.89,
        color: Color(0xFF040444),
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
          TextField(
            controller:nameController,
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
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller:addressController,
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
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller:phoneController,
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
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller:usernameController,
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
          SizedBox(height: 15,),
          TextField(
            controller:emailController,
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
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
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
                      onPressed: () async{
                        String name=nameController.text;
                        String address=addressController.text;
                        String phone=phoneController.text;
                        String username=usernameController.text;
                        String email=emailController.text;
                        String password=passwordController.text;
                        var data = {
                          "name":name,
                          "address":address,
                          "phonenumber":phone,
                          "username":username,
                          "email":email,
                          "password":password
                        };
                        print(data);
                        UserController user = UserController();
                        var r= await user.signup(data);
                        print(r);
                        if(r['success']){
                          print("hi");
                          print(r['data']);
                          await saveUserDataToSharedPreferences(r['data']);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  documentPage()),
                          );
                        }
                        else{
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Driver already exists"),
                              ),
                            );
                          });
                        }
                      },
                      child: const Text("Continue"),
                    ),
                    SizedBox(height: 10,),
                    Text("Already Have an Account?",style: TextStyle(color: Colors.white,fontSize: 18),),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage())
                        );
                      },
                      child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
        ],),
      )
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
