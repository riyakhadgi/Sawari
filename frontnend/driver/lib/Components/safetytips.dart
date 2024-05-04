import'package:flutter/material.dart';
class safteytips extends StatelessWidget {
  const safteytips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("For Comfortable and Safe Ride"),
        ),
        body:SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. Safety First",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Remember to wear a properly fitted helmet to protect your head from accidents."),
                SizedBox(height: 15,),
                Text("2. Stay in Control",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Do not distract your rider or move during ongoing ride. Also, avoid loud phone calls or music during the ride."),
                SizedBox(height: 15,),
                Text("3. Safe and Comfortable Ride",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Feel free to ask your rider to ride slow or within the speed limits."),
                SizedBox(height: 15,),
                Text("4. Equal respect and no Discrimination",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("Remember to greet and thank your rider before and after ride little gesture makes mutual experience much better. Respect your rider and their personal space and privacy. \n We have zero tolerance policy on any kind of discrimination please treat each other with kindness and respect."),
                SizedBox(height: 15,),
                Text("5. Rating your ride",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                Text("After completing your ride remember to give rating to your rider as per your experience throughout your ride journey. Also give feedback for the positive as well as things that can be better for more convenient ride experience."),
              ],
            ),
          ),
        )
    );
  }
}