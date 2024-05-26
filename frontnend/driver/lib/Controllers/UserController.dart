import 'package:dio/dio.dart';
import 'package:driver/Components/Documents.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  String url = 'http://192.168.1.94:8000'; //home
  // String url = 'http://10.22.8.131:8000'; //college
  
  Future<String?> getuserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id');
    return userId;
  }
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

  Future <Map<String, dynamic>> signup(data) async {
    var response = await Dio().post("$url/driversignup/", data: data);
    return response.data;
  }

  Future<Map<String, dynamic>> documents(data) async {
    var userid= await getuserid();
    data['driver'] = userid;
    var response = await Dio().post("$url/document/", data: data);
    return response.data;
  }
}

pickImage(ImageSource source) async{
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if(_file != null){
    return await _file.readAsBytes();
  }
  print(" no Image Selected");
}