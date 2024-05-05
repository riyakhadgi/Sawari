import'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user/Controller/UserController.dart';
class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  bool isLoading= true;
  late int id;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  // UserController user= UserController();
  @override
  void initState() {
    super.initState();
    _getDataFromSharedPreferences();
  }
  Future<void> _getDataFromSharedPreferences() async {
    isLoading=true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    Map<String, dynamic> allData = {};
    for (String key in keys) {
      allData[key] = prefs.get(key);
    }
    print(allData);
    String idString=allData['id']??'';
    _nameController.text = allData['name'] ?? '';
    _emailController.text = allData['email'] ?? '';
    _phoneController.text = allData['phonenumber'] ?? '';
    _addressController.text = allData['address'] ?? '';
    _usernameController.text = allData['username'] ?? '';
    setState(() {
      id = int.tryParse(idString) ?? 0; // Assign 0 if parsing fails
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
        ),
        body:isLoading ? CircularProgressIndicator() : body()
    );
  }

  Widget body(){
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Name:",style: TextStyle(fontFamily: "Poppins",fontSize: 18),),
            SizedBox(height: 5,),
            TextField(
              controller: _nameController, // Assign the TextEditingController
              style: TextStyle(fontFamily: "Poppins", fontSize: 14),
              enabled: false,
            ),
            Text("Username:",style: TextStyle(fontFamily: "Poppins",fontSize: 18),),
            SizedBox(height: 5,),
            TextField(
              controller: _usernameController, // Assign the TextEditingController
              style: TextStyle(fontFamily: "Poppins", fontSize: 14),
              enabled: false,
            ),
            SizedBox(height: 10,),
            Text("Email:",style: TextStyle(fontFamily: "Poppins",fontSize: 18),),
            SizedBox(height: 5,),
            TextField(
              controller: _emailController, // Assign the TextEditingController
              style: TextStyle(fontFamily: "Poppins", fontSize: 14),
              enabled: false,
            ),
            SizedBox(height: 10,),
            Text("Address:",style: TextStyle(fontFamily: "Poppins",fontSize: 18),),
            SizedBox(height: 5,),
            TextField(
              controller: _addressController, // Assign the TextEditingController
              style: TextStyle(fontFamily: "Poppins", fontSize: 14),
              enabled: false,
            ),
            SizedBox(height: 10,),
            Text("Phone:",style: TextStyle(fontFamily: "Poppins",fontSize: 18),),
            SizedBox(height: 5,),
            TextField(
              controller: _phoneController, // Assign the TextEditingController
              style: TextStyle(fontFamily: "Poppins", fontSize: 14),
              enabled: false,
            ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
  Future<void> saveUserDataToSharedPreferences(
      Map<String, dynamic> userData) async {
    var prefs = await SharedPreferences.getInstance();
    userData.forEach((key, value) {
      prefs.setString(key, value.toString());
    });
  }
}