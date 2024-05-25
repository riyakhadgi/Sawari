import 'dart:convert';

import 'package:driver/Components/AcceptedRide.dart';
import 'package:driver/Controllers/RideController.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RideRequestsModal extends StatefulWidget {
  @override
  _RideRequestsModalState createState() => _RideRequestsModalState();
}

class _RideRequestsModalState extends State<RideRequestsModal> {
  final WebSocketChannel channel = IOWebSocketChannel.connect('ws://192.168.1.94:8000/ws/notifications/');
  List<Map<String, dynamic>> rides = [];
  Ride r = Ride();
  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      print("${data}");
      setState(() {
      try {
          var decodedData = jsonDecode(data); // Decode the JSON string
          if (decodedData is Map<String, dynamic> && decodedData.containsKey('message')) {
            var message = decodedData['message']; // Extract the message part
            if (message is Map<String, dynamic>) {
              rides.add(message); // Ensure it's a Map and add to rides
            }
          }
          print("Rides: ${rides[0]} ");
        } catch (e) {
          print('Error decoding JSON: $e');
        }
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  Widget body(int index) {
    if (index >= rides.length) {
      print("from inside body ${rides.length}");
      return Container(); // Return an empty container if the index is out of bounds
    }
    var ride = rides[0];
    return Card(
      child:Container(
        padding: EdgeInsets.all(16),
        child:  Row( 
        children: [
          Text("${ride['distance']} km",style:TextStyle(fontSize: 20),),
          SizedBox(width: 16),
          Column(children: [
            Text("${ride['username']}"),
            Text("${ride['phone']}"),
          ]),
          Spacer(),
          Text("${ride['pickup']} to ${ride['drop']}", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
          SizedBox(width: 16),
          
          Column(
            children: [
              Text("Nrs ${ride['fare']}",style:TextStyle(fontSize: 20),),
              ElevatedButton(onPressed: () async {
                var response = await r.acceptride(ride['id']);
                print(response);
                if(response['success']){
                  print("Ride accepted");
                  Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) =>  acceptedRide(ride['id'])),
                          );
                }
                else{
                  print("Error accepting ride");
                }
              }, child: Text("Accept")),
            ],
          )
          ],),
      )
      
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.5), // Semi-transparent black color
          ),
        ),
        Container(
          height: 400,
          child: Column(
            children: [
              LinearProgressIndicator(),
              SizedBox(height: 16), // Spacer
              Text("Requests", style: TextStyle(fontSize: 24)),
              Expanded(
                child: ListView.builder(
                  itemCount: rides.length,
                  itemBuilder: (context, index) {
                    return body(index);
                  },
                ),
              ),
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
  }
}

void showRequests(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    isScrollControlled: true,
    builder: (context) {
      return RideRequestsModal();
    },
  );
}
