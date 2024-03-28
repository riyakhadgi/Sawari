import 'package:dio/dio.dart';

class UserController {
   bool isAuth=false;

  Future<void> login(String username, String password) async {
   
    var data = {
      "username": username,
      "password": password
    };

    try {
      var response = await Dio().post("http://192.168.1.77:8000/", data: data);
      print(response.data);
      if (response.data['success'] != null && response.data['success'] == true) {
        print("hi");
       isAuth=true;
      } else {
        // Handle login failure
        isAuth= false;
      }
    } catch (e) {
      // Handle Dio errors
      print('Error logging in: $e');
      
    }
  }
}
