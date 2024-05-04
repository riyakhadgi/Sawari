import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                // Add your decoration here if needed
              ),
              child: SvgPicture.asset("logo/logo.svg", width: 200, height: 200),
            ),
            ListTile(
              title: Text("Profile"),
              onTap: () {
                Navigator.pushNamed(context, '/profile'); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Forgot Password'),
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushNamed(context, '/sendEmail');
              },
            ),
            ListTile(
              title: Text('Safety Tips'),
              onTap: () {
                // Update UI based on item selection
                Navigator.pushNamed(context, '/safetytips');
              },
            ),
            ListTile(
              title: Text('Prebooking'),
              onTap: () async{
                Navigator.pushNamed(context, '/prebooking');
              },
            ),
            ListTile(
              title: Text('History'),
              onTap: () async{
                Navigator.pushNamed(context, '/requesthistory');
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.clear();
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),


          ],
        ),
      ),
    );
  }
}
