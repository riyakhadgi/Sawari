import 'package:dio/dio.dart';
import 'package:user/pages/sendEmail.dart';

class UserController {
  // String url = 'http://192.168.1.66:8000'; //home
  // String url = 'http://10.22.31.33:8000'; //college
 String url= 'http://192.168.43.156:8000';  //2
  Future<Map<String, dynamic>> login(String username, String password) async {
    var data = {"username": username, "password": password};
    var response = await Dio().post("$url/", data: data);
    return response.data;
  }


  Future<Map<String, dynamic>> signup(dynamic data) async {
    print(data);
    var response = await Dio().post("$url/signup/", data: data);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> updateuser(data,id) async {
    var response = await Dio().put("$url/editpassengerdata/${id}/", data: data);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> sendEmail(email) async {
    var response = await Dio().post("$url/verifypassenger/", data: {"email":email});
    return response.data;
  }

  Future<Map<String, dynamic>> verifyOtp(data) async {
    var response = await Dio().post("$url/verifyotp/", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> updatepassword(data) async {
    var response = await Dio().post("$url/updatepasswordpassenger/", data: data);
    return response.data;
  }
}
