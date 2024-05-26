import 'package:driver/Components/Drawer.dart';
import 'package:driver/Components/RequestsModal.dart';
import 'package:driver/Controllers/RideController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'dart:math' show cos, sqrt, asin;
import 'package:open_route_service/open_route_service.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key});
    @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Ride ride= Ride();
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double lat = 0.0;
  double long = 0.0;
  String userLocation = '';
  late TextEditingController pickupLocationController;
  late TextEditingController destinationController;
  late TextEditingController fareController;
  late Marker destinationMarker;
  double distance = 0.0;
  List<Marker> markerData = [];
  List<Polyline> polylineData = [];
  late final WebSocketChannel channel;
  List<dynamic> allrides=[];

     // final channel = WebSocketChannel.connect(Uri.parse('ws://192.168.1.66:8000/ws/notifications/'));
  @override
  void dispose() {
    pickupLocationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // channel = IOWebSocketChannel.connect('ws://192.168.1.94:8000/ws/notifications/');

    // Listen for messages from the WebSocket channel
    // channel.stream.listen(
    //       (message) async{
    //     print("Received message: $message");
    //     var response = await ride.getrides();
    //     if( response['success']){
    //       setState(() {
    //         allrides.add(response['data']);
    //       });
    //     }
    //     else{
    //       print(response['message']);
    //     }
    //   },
    //   onError: (error) {
    //     print("Error occurred: $error");
    //   },
    //   onDone: () {
    //     print("WebSocket channel closed");
    //   },
    // );
    pickupLocationController = TextEditingController();
    destinationController = TextEditingController();
    fareController=TextEditingController();
    _getUserLocation();
    _getrides();
    // print(allrides);
  }

  void _getrides()async{
    var response = await ride.getrides();

    if( response['success']){
      print("inside get_rides");
      setState(() {
        allrides.add(response['data']);
      });
    }
    else{
      print(response['message']);
    }
  }


  void _getUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      print(position);

      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        userLocation = '${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}';
        print(userLocation);
      } else {
        print('No placemarks found.');
      }

      if (position != null) {
        print(position.latitude);
        print(position.longitude);

        setState(() {
          lat = position.latitude;
          long = position.longitude;
          isLoading = false;
          markerData.add(
            Marker(
              point: LatLng(lat, long),
              width: 50,
              height: 50,
              alignment: Alignment.centerLeft,
              child:Icon(
                Icons.location_pin,
                size: 20,
                color: Colors.red,
              ),
            ),
          );
        });
      } else {
        print('Error: position is null');
      }
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: SvgPicture.asset("logo/logo.svg", width: 200, height: 200),
        actions: [
          IconButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              Map<String, dynamic> allData = prefs.getKeys().fold<Map<String, dynamic>>(
                {},
                    (previousValue, key) {
                  previousValue[key] = prefs.get(key);
                  return previousValue;
                },
              );

              print(allData);
            },
            icon: Icon(Icons.location_on),
          ),
          IconButton(
            onPressed: () {
              // Open the drawer
              _scaffoldKey.currentState!.openDrawer();
            },
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: isLoading ? CircularProgressIndicator() : body(),
    );
  }




  Widget body() {
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: LatLng(lat, long),
            zoom: 17,
            interactionOptions: const InteractionOptions(
              flags: ~InteractiveFlag.doubleTapZoom,
            ),
          ),
          children: [
            openStreetMapTileLayer, // Make sure openStreetMapTileLayer is correctly defined
            MarkerLayer(
              markers: markerData,
            ),
            PolylineLayer(
              polylines: polylineData,
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                showRequests(context);
              },
              child: Text('Show Rides'),
            ),
          ),
        ),


      ],
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );




}
