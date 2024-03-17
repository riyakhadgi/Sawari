import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MapController controller = MapController(
      initPosition: GeoPoint(latitude: 27.7122811, longitude: 85.3309045), // Kathmandu, Nepal
    );

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
      ),
      body: OSMFlutter(
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
    );
  }
}
