import 'dart:io';

import 'package:driver/Controllers/RideController.dart';
import 'package:flutter/material.dart';

class acceptedRide extends StatefulWidget {

   final int rideId;

  acceptedRide(this.rideId);
  @override
  State<acceptedRide> createState() => _acceptedRideState();
}

class _acceptedRideState extends State<acceptedRide> {
  bool isLoading=true;
  Ride ride = new Ride();
  Map<String,dynamic> rideData={};

  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }
  void getdata()async {
    var response = await ride.getride(widget.rideId);
    print(response);
    if(response['success']){
      setState(() {
        rideData=response['data'];
        isLoading=false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Accepted Ride"),
      ),
      body: isLoading?CircularProgressIndicator():body(), 
    );
  }
  SingleChildScrollView body(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Text("Ride Details",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          SizedBox(height: 20,),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Name",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("${rideData['username']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Phone",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("${rideData['phone']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Pickup Location",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("${rideData['pickup']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Drop Location",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("${rideData['drop']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Distance",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("${rideData['distance']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
            Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Text("Fare",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Text("${rideData['fare']}",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
            ],),
          Divider(),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            var response = await ride.endride(widget.rideId);
            if(response['success']){
              Navigator.pushReplacementNamed(context, '/dashboard');
            }
            else{
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
            }
          }, child: Text("End Ride")),
        ],),
      ),

  );
  }
}