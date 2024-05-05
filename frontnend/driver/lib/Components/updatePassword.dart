import 'package:driver/Components/LoginPage.dart';
import 'package:driver/Controllers/UserController.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class updatePassword extends StatefulWidget {
  const updatePassword({super.key});

  @override
  State<updatePassword> createState() => _updatePasswordState();
}

class _updatePasswordState extends State<updatePassword> {
  bool isPasswordVisible = false;
  bool isConfirmPassword=false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        appBar: AppBar(
          title: Text("Update Password"),
          centerTitle: true,
        ),
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Text("Enter new password below"),
                SizedBox(height: 10,),
                TextField(
                  controller: passwordController,
                  obscureText: !isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: confirmpasswordController,
                  obscureText: !isConfirmPassword,
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          isConfirmPassword = !isConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () async{
                  String password = passwordController.text;
                  String confirmpassword=confirmpasswordController.text;
                  if(password==confirmpassword){
                    var data= {
                      "password": password,
                      "email": email
                    };
                    var response = await UserController().updatepassword(data);
                    if(response['success']){
                      var prefs = await SharedPreferences.getInstance();
                      prefs.clear();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginPage()),
                      );
                    }
                  }
                }, child: Text("Update"))
              ],
            ),
          ),
        )
    );
  }
}
