import 'package:dio/dio.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';


class RequestedRide{
  final String name;
  final String pickupLocation;
  final String dropLocation;
  final num fare;
  final num distance;

  RequestedRide ({
    required this.name,
    required this.pickupLocation,
    required this.dropLocation,
    required this.fare,
    required this.distance
  });


}

class Ride {
  String url = 'http://192.168.1.94:8000'; //home
  // String url = 'http://10.22.8.131:8000'; //college

  final channel = IOWebSocketChannel.connect('ws://192.168.1.94:8000/ws/notifications/');
  
  Future<String?> getuserid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('id');
    return userId;
  }
  Future<Map<String, dynamic>> getrides() async {
    var response = await Dio().get("$url/book/gettemp/",);
    return response.data;
  }
  Future<Map<String, dynamic>> getprebooking() async {
    var response = await Dio().get("$url/book/getprebooking/",);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> acceptride(int id) async {
    var userid= await getuserid();
    var data={
      "driver":userid,
      "ride":id
    };
    var response = await Dio().post("$url/book/acceptride/", data: data);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> acceptprebooking(int id) async {
    var userid= await getuserid();
    var data={
      "driver":userid,
      "prebooking":id
    };
    var response = await Dio().post("$url/book/acceptprebooking/", data: data);
    print(response.data);
    return response.data;
  }

  Future<Map<String, dynamic>> getride(int id) async {
    var response = await Dio().get("$url/book/getrideinfo/$id/",);
    return response.data;
  }
  
  Future<Map<String, dynamic>> endride(int id) async {
    print(id);

    var response = await Dio().post("$url/book/endride/$id/",);
    return response.data;
  }

  Future<Map<String, dynamic>> getacceptedrides() async {
    var userid= await getuserid();
    var response = await Dio().get("$url/book/getdriveraccept/$userid/",);
    return response.data;
  }

  Future<Map<String, dynamic>> endprebook(int id) async {
    print(id );
    var response = await Dio().post("$url/book/endprebook/$id/",);
    return response.data;
  }
}