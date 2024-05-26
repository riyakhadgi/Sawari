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
    final WebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.1.94:8000/ws/notifications/');
    Map<String, dynamic> driver = {};
    int count=0;
  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      print("${data}");
        try {
          var decodedData = jsonDecode(data); // Decode the JSON string
          if (decodedData is Map<String, dynamic> && decodedData.containsKey('message')) {
            var message = decodedData['message']; // Extract the message part
            if (message is Map<String, dynamic>) {
              setState(() {
                driver = message; // Update the driver details
              });
              count++;
              print('count: $count'); 
              print('Driver: $driver'); // Print the driver details	 

            }
          }

        } catch (e) {
          print('Error decoding JSON: $e');
        }
    
    }, onError: (error) {
      print("WebSocket error: $error");
    }, onDone: () {
      print("WebSocket closed");
    });
  }
  
  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
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
          if(count == 0) Container(
            height: 200,
            color: Color(0xFF040444),
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
            )
          )
          else 
          Container(
            height: 200,
            color: Color(0xFF040444),
            child: Card(
              color: Color(0xFF040444),
              child: Column(
              children: [
              Text("Driver Found",style: TextStyle(fontSize: 30,color: Colors.white),),
              Divider(color: Colors.white,thickness: 2,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Column(children: [
                  Text("Driver Name",style: TextStyle(fontSize: 20,color: Colors.white),),
                  Text ("${driver['name']}",style: TextStyle(fontSize: 15,color: Colors.white),), 
                ],),
                Column(children: [
                  Text("Driver Phone",style: TextStyle(fontSize: 20,color: Colors.white),),
                  Text ("${driver['phone']}",style: TextStyle(fontSize: 15,color: Colors.white),),
                ],),
                Column(
                  children: [
                    Text("Vehicle",style: TextStyle(fontSize: 20,color: Colors.white),),
                    Text ("${driver['vechile']}",style: TextStyle(fontSize: 15,color: Colors.white),),
                  Text ("${driver['vechileNumber']}",style: TextStyle(fontSize: 15,color: Colors.white),),
                  ],
                )
              ],),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text("Done"),
                ),
            ],
            )
            ,
            )
            ),
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