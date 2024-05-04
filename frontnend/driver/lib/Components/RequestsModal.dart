import 'package:driver/Controllers/RideController.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void showrequests(BuildContext context) {
  final WebSocketChannel  channel = IOWebSocketChannel.connect('ws://192.168.1.66:8000/ws/notifications/');
  Ride ride=Ride();
  ride.getrides();
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (context) {
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
          Container(
            height: 200,
            color: Colors.blue,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 16), // Spacer
                StreamBuilder(
                  stream: channel.stream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show a loading indicator while waiting for data
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}'); // Show an error message if there's an error
                    } else if (snapshot.hasData) {
                      // Show the data if available
                      return Text("${snapshot.data}");
                    } else {
                      return Text('No data'); // Show a message when there's no data available
                    }
                  },
                ),
                SizedBox(height: 16), // Spacer
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}