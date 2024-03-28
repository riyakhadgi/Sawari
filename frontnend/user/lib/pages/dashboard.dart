import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
    Widget build(BuildContext context) {
    return Scaffold (
      appBar:AppBar(
        leading: SvgPicture.asset("logo/logo.svg",width:200,height:200),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.menu),)
        ],
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
        
            height: 300,
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
          ),
          Container(
            child: Column(children: [
             TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Pickup Location',
        ),
             ),
        TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Destination',
        ),),
        TextField( decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Enter your fare here',
        ),),
              
        ]),
        )
        ]

        )
        ); 
  }
}