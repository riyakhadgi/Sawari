import 'package:dio/dio.dart';
import 'package:latlng/latlng.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Book{
 final url = 'http://192.168.1.77:8000';

 Future<String?> getuserid()async{
  SharedPreferences prefs =  await SharedPreferences.getInstance();
  String? userId = prefs.getString('id');
  return userId;
 }
 Future<Map<String,dynamic>> addBooking(data)async {
  String? userid= await getuserid();
  data['user']=userid;
  print(userid);
  print("from controller");
  print(data);

   var response = await Dio().post("$url/book/addtemp/", data: data);
   return response.data;

 }
}