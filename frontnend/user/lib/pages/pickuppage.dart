import 'package:flutter/material.dart'; 
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
class pickuppage extends StatefulWidget {
  const pickuppage({super.key});

  @override
  State<pickuppage> createState() => _pickuppageState();
}

class _pickuppageState extends State<pickuppage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar:AppBar(
        title: Text("Book Gar"),
        centerTitle: true,
      ),
      body:body()
    );
  }
   MapController controller = MapController(
      initPosition: GeoPoint(latitude: 27.7122811, longitude: 85.3309045), // Kathmandu, Nepal
    );
  SingleChildScrollView body(){
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: 500,
            height: 500,
            child:  OSMFlutter(
      controller: controller,
      osmOption: OSMOption(
        userTrackingOption: const UserTrackingOption(
          enableTracking: true,
          unFollowUser: false,
        ),
        zoomOption: const ZoomOption(
          initZoom: 8,
          minZoomLevel: 3,
          maxZoomLevel: 19,
          stepZoom: 1.0,
        ),
        userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(
              Icons.location_history_rounded,
              color: Colors.red,
              size: 48,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(
              Icons.double_arrow,
              size: 48,
            ),
          ),
        ),
        roadConfiguration: const RoadOption(
          roadColor: Colors.yellowAccent,
        ),
        markerOption: MarkerOption(
          defaultMarker: const MarkerIcon(
            icon: Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 56,
            ),
          ),
        ),
      ),
            ),
          )
        ],),
    );
  }
}