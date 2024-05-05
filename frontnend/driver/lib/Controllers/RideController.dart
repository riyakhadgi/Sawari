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
  // String url = 'http://192.168.1.66:8000'; //home
  // String url = 'http://10.22.31.33:8000'; //college
  String url= 'http://10.22.21.108:8000';  //2
  final channel = IOWebSocketChannel.connect('ws://10.22.21.108:8000/ws/notifications/');
  Ride() {
    // Listen for notifications when the object is created
    channel.stream.listen((message) {
      print("Received notification: $message");
    });
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
}