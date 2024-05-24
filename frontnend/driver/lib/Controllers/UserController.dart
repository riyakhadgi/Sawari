import 'package:dio/dio.dart';

class UserController {
  // String url = 'http://192.168.1.66:8000'; //home
  String url = 'http://10.22.8.131:8000'; //college
  // String url= 'http://192.168.1.94:8000';  //2

  Future<Map<String, dynamic>> login(String username, String password) async {
    var data = {"username": username, "password": password};
    print(data);
    var response = await Dio().post("$url/driverlogin/", data: data);
    print(response.data);
    return response.data;
  }
  Future<Map<String, dynamic>> sendEmail(email) async {
    var response = await Dio().post("$url/verifydriver/", data: {"email":email});
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOtp(data) async {
    var response = await Dio().post("$url/verifyotp/", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updatepassword(data) async {
    var response = await Dio().post("$url/updatepassworddriver/", data: data);
    return response.data;
  }
}
