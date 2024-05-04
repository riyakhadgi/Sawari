import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class Listen extends StatefulWidget {
  const Listen({Key? key}) : super(key: key);

  @override
  State<Listen> createState() => _ListenState();
}

class _ListenState extends State<Listen> {
  late IOWebSocketChannel channel;
  String message = '';

  @override
  void initState() {
    super.initState();
    // Initialize WebSocket channel
    channel = IOWebSocketChannel.connect('ws://172.28.128.1:8000/ws/notifications/');
    // Listen for incoming messages
    channel.stream.listen((data) {
      setState(() {
        // Parse the incoming JSON message
        print("hi");
        final parsedData = jsonDecode(data);
        message = parsedData['message'];
      });
    });
  }

  @override
  void dispose() {
    // Close WebSocket channel when the widget is disposed
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Listener'),
      ),
      body: Center(
        child: Text(message), // Display the received message
      ),
    );
  }
}
