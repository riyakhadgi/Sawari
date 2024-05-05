import 'package:driver/Controllers/RideController.dart';
import 'package:flutter/material.dart';
class Prebooking extends StatefulWidget {
  const Prebooking({super.key});

  @override
  State<Prebooking> createState() => _PrebookingState();
}

class _PrebookingState extends State<Prebooking> {
  Ride ride = new Ride();
  bool isLoading= true;
  List<dynamic> prebooks=[];
  @override
  void initState() {
    super.initState();
    getdata();
  }

  Future<void> getdata()async {
    var response = await ride.getprebooking();
    print("from getdata $response");
    if(response['success']){
      setState(() {
        prebooks.add(response['data']);
        isLoading= false;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Pre-bookings"),
        centerTitle: true,
      ) ,
      body: isLoading ? CircularProgressIndicator() : body(),
    );
  }
  Widget body(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("${prebooks}"),
          ],
        ),
      ),
    );
  }
}
