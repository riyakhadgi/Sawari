// import 'package:flutter/material.dart';
// import 'package:open_street_map_search_and_pick/open_street_map_search_and_pick.dart';
//
// class PickupPage extends StatefulWidget {
//   const PickupPage({Key? key, required String userLocation}) : super(key: key);
//
//   @override
//   State<PickupPage> createState() => _PickupPageState();
// }
//
// class _PickupPageState extends State<PickupPage> {
//   String locationAddress = "Pick location";
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: Icon(Icons.arrow_back),
//         ),
//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: Icon(Icons.close),
//           ),
//         ],
//       ),
//       body: Container(
//         child: InkWell(
//           child: Text(locationAddress),
//           onTap: () {
//             _showModal(context);
//           },
//         ),
//       ),
//     );
//   }
// }
//
// // Modal bottom sheet
// void _showModal(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     builder: (context) {
//       return Container(
//         height: 200,
//         child: Center(
//           child: OpenStreetMapSearchAndPick(
//             center: LatLong(23, 89),
//             buttonColor: Colors.blue,
//             buttonText: 'Set Current Location',
//             onPicked: (pickedData) {
//               Navigator.pop(context);
//               setState((
//               locationaddress=pickedData.address;
//               ));
//             },
//           ),
//         ),
//       );
//     },
//   );
// }
