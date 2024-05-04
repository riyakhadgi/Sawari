import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user/Controller/UserController.dart';
class sendEmail extends StatefulWidget {
  const sendEmail({super.key});

  @override
  State<sendEmail> createState() => _sendEmailState();
}

class _sendEmailState extends State<sendEmail> {
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter Your Email"),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Please enter your email below so that we can send you an OTP code to verify it is you."),
              SizedBox(height: 10,),
              TextField(
                controller: emailcontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder()
                )
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () async{
                String email = emailcontroller.text;
                var response = await UserController().sendEmail(email);
                if(response['success']){
                  Navigator.pushNamed(context, "/verifyOtp",arguments: email);
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(response['message']),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              }, child: Text("Send Email"))
            ],
          ),
        ),
      )
    );
  }
}
