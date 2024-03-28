import'package:flutter/material.dart';
class safteytips extends StatelessWidget {
  const safteytips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
        actions: [Text("For Comfortable and Safe Ride")],
      ),
      body: Container(child:Column(children: [
       Text("Safety First \n Remember to wear a properly fitted helmet to protect your head from accidents. \n 2. Stay in Control \n Do not distract your rider or move during ongoing ride. Also, avoid loud phone calls or music during the ride. \n 3. Safe and Comfortable Ride. \n Feel free to ask your rider to ride slow or within the speed limits. \n 4. Equal respect and no Discrimination \n Remember to greet and thank your rider before and after ride little gesture makes mutual experience much better. Respect your rider and their personal space and privacy. \n We have zero tolerance policy on any kind of discrimination please treat each other with kindness and respect. \n 5. Rating your ride \n After completing your ride remember to give rating to your rider as per your experience throughout your ride journey. Also give feedback for the positive as well as things that can be better for more convenient ride experience."),
      ],),),
    );
  }
}