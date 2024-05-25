import 'package:driver/Components/Dashboard.dart';
import 'package:driver/Controllers/RideController.dart';
import 'package:flutter/material.dart';

class Prebooking extends StatefulWidget {
  const Prebooking({Key? key});

  @override
  State<Prebooking> createState() => _PrebookingState();
}

class _PrebookingState extends State<Prebooking> {
  Ride ride = new Ride();
  bool isLoading = true;
  List<Map<String,dynamic>> prebooks = [];
  List<Map<String,dynamic>> accepeted = [];

  @override
  void initState() {
    super.initState();
    getdata();
    getacceptedrides();
  }

  Future<void> getdata() async {
    var response = await ride.getprebooking();
    print("from getdata ${response['data']}");
    if (response['success']) {
      setState(() {
        for (var i in response['data']) {
          prebooks.add(i);
        }
        isLoading = false;
      });
    }
  }

  Future<void> getacceptedrides() async {
    var response = await ride.getacceptedrides();
    
    if (response['success']) {
      setState(() {
        accepeted.add(response['data']);
        isLoading = false;
      });
    }
    print("from getacceptedrides $accepeted");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pre-bookings"),
        centerTitle: true,
      ),
      body: isLoading ? CircularProgressIndicator() : body(),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              "Already-booked",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),  
            ListView.builder(
              shrinkWrap: true,
              itemCount: accepeted.length,
              itemBuilder: (context, index) {
                return booked(index);
              },
            ),
            Text(
              "Pre-bookings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: prebooks.length,
              itemBuilder: (context, index) {
                return prebookcard(index);
              },
            )
          ],
        ),
      ),
    );
  }

  Card prebookcard(index) {
    print("prebookcard called $index");
    var prebook = prebooks[index];
    DateTime datetime = DateTime.parse(prebook['datetime']);
    int year = datetime.year;
    int month = datetime.month;
    int day = datetime.day;
    int hour = datetime.hour;
    int minute = datetime.minute;
    int second = datetime.second;
    String date= "$year-$month-$day";
    String time= "$hour:$minute:$second";
    print(prebook);
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            // Text("$prebook"),
            Column(
              children: [
                Text("${date}"),
                Text("${time}"),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text("${prebook['username']}"),
                Text("${prebook['phone']}"),
              ],
            ),
            Spacer(),
            Text('${prebook['pickup']} to ${prebook['drop']}'),
            Spacer(),
            Column(
              children: [
                Text("Nrs ${prebook['fare']}"),
                ElevatedButton(
                  onPressed: () async {
                    var response = await ride.acceptprebooking(prebook['id']);
                    print(response);
                    if (response['success']) {
                      print("Prebooking accepted");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    } else {
                      print("Error accepting prebooking");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error accepting prebooking"),
                        ),
                      );
                    }
                  },
                  child: Text("Accept"),
                ),
              ],
            )
            ],)
        ),
    );
  }

  Card booked(index) {
    var already = accepeted[index];
    DateTime datetime = DateTime.parse(already['datetime']);
    int year = datetime.year;
    int month = datetime.month;
    int day = datetime.day;
    int hour = datetime.hour;
    int minute = datetime.minute;
    int second = datetime.second;
    String date= "$year-$month-$day";
    String time= "$hour:$minute:$second";
    // print(prebook);
    return Card(
      color: Colors.green,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            // Text("$prebook"),
            Column(
              children: [
                Text("${date}"),
                Text("${time}"),
              ],
            ),
            Spacer(),
            Column(
              children: [
                Text("${already['username']}"),
                Text("${already['phone']}"),
              ],
            ),
            Spacer(),
            Text('${already['pickup']} to ${already['drop']}'),
            Spacer(),
            Column(
              children: [
                Text("Nrs ${already['fare']}"),
                ElevatedButton(
                  onPressed: () async {
                    var response = await ride.endprebook(already['id']);
                    print(response);
                    if (response['success']) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    } else {
                      print("Error accepting prebooking");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Error ending prebooking"),
                        ),
                      );
                    }
                  },
                  child: Text("End Ride"),
                ),
              ],
            )
            ],)
        ),
    );
  }
}
