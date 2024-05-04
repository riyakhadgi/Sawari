import 'package:dio/dio.dart';

class UserController {
  String url = 'http://192.168.1.66:8000';

  Future<Map<String, dynamic>> login(String username, String password) async {
    var data = {"username": username, "password": password};
    print(data);
    var response = await Dio().post("$url/driverlogin/", data: data);
    print(response.data);
    return response.data;
  }
}
