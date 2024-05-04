import 'package:flutter/material.dart';
import 'package:user/Controller/UserController.dart';
class verifyOtp extends StatefulWidget {
  const verifyOtp({super.key});

  @override
  State<verifyOtp> createState() => _verifyOtpState();
}

class _verifyOtpState extends State<verifyOtp> {
  TextEditingController otpController= TextEditingController();

  // @override
  // void initState() {
  //   super.initState();
  //   email = ModalRoute.of(context)!.settings.arguments as String;
  // }
  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify otp"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text("Enter the OTP code we have send in the email"),
              SizedBox(height: 10,),
              TextField(
                  controller: otpController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    label: Text("Enter Otp here"),
                  )
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () async{
                String otp = otpController.text;
                var data={
                  "otp":otp,
                  "email": email
                };
                var response = await UserController().verifyOtp(data);
                if(response['success']){
                  Navigator.pushNamed(context, "/updatepassword",arguments: email);
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(response['message']),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              }, child: Text("Verify OTP"))
            ],
          ),
        ),
      ),
    );
  }
}
