import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = true;
  double lat = 0.0;
  double long = 0.0;
  String userLocation = '';
  late TextEditingController pickupLocationController;
  late TextEditingController destinationController;
  late Marker destinationMarker;
  List<Marker> markerData = [];
  List<Polyline> polylineData = [];


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
      appBar: AppBar(
        leading: SvgPicture.asset("logo/logo.svg", width: 200, height: 200),
        actions: [
          IconButton(
            onPressed: () async{
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
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
        ],
      ),
      body: isLoading ? CircularProgressIndicator(): body(),
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
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your fare here',
                  ),
                ),

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
  // TileLayer  openStreetMapTileLayer() {
  //   return TileLayer(
  //     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
  //     userAgentPackageName: 'dev.fleaflet.flutter_map.example',
  //   );
  // }

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
                onPicked: (pickedData) {
                  setState(() {
                    destinationController.text = pickedData.addressName;
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
                    polylineData.add(
                      Polyline(
                        points: [LatLng(lat, long), LatLng(pickedData.latLong.latitude, pickedData.latLong.longitude)],
                        color: Colors.blue,
                        strokeWidth: 3.0,
                      ),
                    );
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
          // Update the destination marker
          markerData.add(destinationMarker);
        });
      }
    });
  }





}
