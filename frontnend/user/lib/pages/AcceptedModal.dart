import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class AcceptedModal extends StatefulWidget {
  const AcceptedModal({super.key});

  @override
  State<AcceptedModal> createState() => _AcceptedModalState();
}

class _AcceptedModalState extends State<AcceptedModal> {
    final WebSocketChannel channel = IOWebSocketChannel.connect('ws:// 192.168.43.156:8000/ws/notifications/');
    Map<String, dynamic> driver = {};
  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      print("${data}");
      setState(() {
        driver = json.decode(data);
      });
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
        alignment: Alignment.center,
        children: [
          // Background content
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent black color
            ),
          ),

          // Modal content
          driver == null ? Container(
            height: 200,
            color: Colors.blue,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 16), // Spacer
                Text("Searching Driver",style: TextStyle(fontSize: 20,color: Colors.white),),
                SizedBox(height: 16), // Spacer
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ):
          Container(
            child: Row(
              children: [
                Column(
                  children: [
                    Text("Driver Name: ${driver['driver_name']}"),
                    Text("Driver Phone: ${driver['driver_phone']}"),
                  ],
                  
                ),
                  Text("Driver Car: ${driver['driver_car']}"),
                    Text("Driver Plate: ${driver['driver_plate']}"),
              ],
            
            ),
          )
        ],
      );
  }
}

void showWaitingModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (context) {
      return AcceptedModal();
    },
  );
}