import 'package:dio/dio.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';


class Ride {
  String url = 'http://192.168.1.66:8000';
  final channel = IOWebSocketChannel.connect('ws://192.168.1.66:8000/ws/notifications/');
  Ride() {
    // Listen for notifications when the object is created
    channel.stream.listen((message) {
      print("Received notification: $message");
    });
  }
  Future<Map<String, dynamic>> getrides() async {
    var response = await Dio().get("$url/book/gettemp",);
    print(response.data);
    return response.data;
  }
}