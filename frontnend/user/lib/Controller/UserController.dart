import 'package:dio/dio.dart';

class UserController {
  Future<void> login(String username, String password) async {
    var data = {
      "username": username,
      "password": password
    };
    print(data);
    try {
      var response = await Dio().post("https://sawari.onrender.com/", data: data);
      print(response);
      // Handle the response here
    } catch (e) {
      // Handle any errors
      print('Error logging in: $e');
    }
  }
}
