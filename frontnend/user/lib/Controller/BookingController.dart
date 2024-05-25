import 'package:dio/dio.dart';
import 'package:latlng/latlng.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';


class Book {
 // String url = 'http://192.168.1.66:8000'; //home
 // String url = 'http://10.22.31.33:8000'; //college
 String url= 'http://192.168.43.156:8000';  //2
 final channel = IOWebSocketChannel.connect(
     'ws:// 10.22.21.108:8000/ws/notifications/');
 Book() {
  // Listen for notifications when the object is created
  channel.stream.listen((message) {
   print("Received notification: $message");
   // Handle incoming messages (notifications) here
  });
 }

 Future<Map<String, dynamic>> addBooking(data) async {
  try {
   String? userid = await getuserid();
   data['user'] = userid;
   print(userid);
   print("from controller");
   print(data);

   var response = await Dio().post("$url/book/addtemp/", data: data);
   return response.data;
  } catch (e) {
   print("Error: $e");
   return {'success': false, 'message': 'An error occurred.'};
  }
 }
 Future<String?> getuserid() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('id');
  return userId;
 }

 Future<Map<String, dynamic>> bookinghistory() async {
  String? userid = await getuserid();
  var response = await Dio().get("$url/book/getridehistory/${userid}/");
  print(response.data);
  return response.data;
 }

 Future<Map<String, dynamic>> addPreBooking(data) async {
  try {
   String? userid = await getuserid();
   data['user'] = userid;
   var response = await Dio().post("$url/book/addprebooking/", data: data);
   print(response.data);
   return response.data;
  } catch (e) {
   print("Error: $e");
   return {'success': false, 'message': 'An error occurred.'};
  }
 }

}
