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
import 'package:user/Controller/BookingController.dart';
import 'package:user/pages/AcceptedModal.dart';
import 'package:user/pages/Drawer.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
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
  final channel = IOWebSocketChannel.connect('ws://192.168.1.94:8000/ws/notifications/');
  Book book=new Book();


  @override
  void dispose() {
    pickupLocationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    super.initState();
    pickupLocationController = TextEditingController();
    destinationController = TextEditingController();
    fareController=TextEditingController();
    _getUserLocation();
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
          pickupLocationController.text = userLocation;
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




  SingleChildScrollView body() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 300,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: LatLng(lat, long),
                initialZoom: 17,
                interactionOptions: const InteractionOptions(flags: ~InteractiveFlag.doubleTapZoom),

              ),
              children: [
                openStreetMapTileLayer, // Make sure openStreetMapTileLayer is correctly defined
                MarkerLayer(
                    markers: markerData
                ),
                PolylineLayer(
                  polylines: polylineData,
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Container(
            child:  Column(
              children: [
                TextField(
                  controller: pickupLocationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pickup Location',
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  child:  TextField(
                    controller: destinationController,
                    readOnly: true,
                    onTap: (){
                      _showModal(context);
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Destination',

                    ),
                  ),
                  onTap: (){
                    _showModal(context);
                  },
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: fareController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your fare here',
                  ),
                ),
                SizedBox(height: 10,),
                ElevatedButton(onPressed: () async {
                  String fare = fareController.text;
                  String pickup= pickupLocationController.text;
                  String destination=destinationController.text;

                  Map<String,dynamic> data={
                    "pickup":pickup,
                    "drop":destination,
                    "distance":distance,
                    "fare": fare,
                  };

                  var response=await book.addBooking(data);

                  print(response);
                  if(response['success']){
                    showWaitingModal(context);
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(response['message']),
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }
                }
                    , child: Text("Book Now"))
              ],
            ),
          )
        ],
      ),
    );
  }

  TileLayer get openStreetMapTileLayer => TileLayer(
    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  );


  void _showModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              height: 500,
              child: OpenStreetMapSearchAndPick(
                buttonColor: Colors.blue,
                buttonText: 'Set Current Location',
                onPicked: (pickedData) async {

                  await _drawRoute(
                    LatLng(lat, long),
                    LatLng(pickedData.latLong.latitude, pickedData.latLong.longitude),
                  );
                  setState(() {
                    destinationController.text = shortenAddressName(pickedData.addressName);
                    destinationMarker = Marker(
                      point: LatLng(pickedData.latLong.latitude, pickedData.latLong.longitude),
                      width: 50,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.location_pin,
                        size: 20,
                        color: Colors.blue,
                      ),
                    );
                    //   add polylines
                  });
                  Navigator.pop(context); // Close the modal bottom sheet
                },
              ),
            );
          },
        );
      },
    ).then((_) {
      if (destinationController.text.isNotEmpty) {
        setState(() {
          if (markerData.length == 2) {
            markerData.removeAt(1);
          }

          // Update the destination marker
          markerData.add(destinationMarker);
        });
      }
    });
  }
  Future<void> _drawRoute(LatLng start, LatLng end) async {
    final OpenRouteService client = OpenRouteService(
      apiKey: '5b3ce3597851110001cf624874a719d60289444fba4937618bebd19b',
    );

    final List<ORSCoordinate> routeCoordinates = await client.directionsRouteCoordsGet(
        startCoordinate: ORSCoordinate(latitude: start.latitude, longitude: start.longitude),
        endCoordinate: ORSCoordinate(latitude: end.latitude, longitude: end.longitude),
        profileOverride: ORSProfile.drivingCar
    );
    if (routeCoordinates.isNotEmpty) {

      for (int i = 0; i < routeCoordinates.length - 1; i++) {
        var newdistance =calculateDistance(routeCoordinates[i].latitude,routeCoordinates[i].longitude, routeCoordinates[i+1].latitude, routeCoordinates[i+1].longitude);
        distance += newdistance;
      }
      final List<LatLng> routePoints = routeCoordinates
          .map((coordinate) => LatLng(coordinate.latitude, coordinate.longitude))
          .toList();
      // final fare= _calculatefare(distance);
      setState(() {
        polylineData.clear();
        polylineData.add(
          Polyline(
            points: routePoints,
            color: Colors.blue,
            strokeWidth: 3.0,
          ),
        );
      });
      double fare=_calculateFare(distance);
      setState(() {
        fareController.text=fare.toStringAsFixed(2);;
      });
      print('Distance: $distance km');
      print('Fare: Rs $fare');
    }

  }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  double _calculateFare(double distance){
    //       1km=Rs10
    //    1km=1000m
    //    1000m=Rs10
    //    1m=rs0.01
    double fare = distance * 10.0; // fare for distance in km
    fare = fare.ceilToDouble(); // rounding up the fare value
    return fare;
  }
  String shortenAddressName(String addressName) {
    List<String> parts = addressName.split(',').take(2).toList();
    return parts.join(', ');
  }

}
