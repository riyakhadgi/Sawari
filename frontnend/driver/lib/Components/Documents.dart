import "dart:convert";
import "dart:typed_data";

import "package:driver/Controllers/UserController.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";

class documentPage extends StatefulWidget {
  const documentPage({super.key});

  @override
  State<documentPage> createState() => _documentPageState();
}

class _documentPageState extends State<documentPage> {
  TextEditingController citizenshipnumberController = TextEditingController();
  TextEditingController licensenumberController = TextEditingController();
  TextEditingController vechilenumberController = TextEditingController(); 
  TextEditingController vechilemodelController = TextEditingController();

  UserController user = new UserController();
  // images
  Uint8List? licensefront;
  Uint8List? licenseback;
  Uint8List? citizenshipfront;
  Uint8List? citizenshipback;
  Uint8List? vechile1;
  Uint8List? vechile2;

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF040444),
        title: Text("Documents",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: body(),
    );
  }
  SingleChildScrollView body(){
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        // height: MediaQuery.of(context).size.height*0.89,
        color: Color(0xFF040444),
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
            controller: citizenshipnumberController,
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when focused
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when not focused
                  ),
                ),
                labelText: 'Enter your citizenship number ',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: licensenumberController,
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when focused
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when not focused
                  ),
                ),
                labelText: 'Enter your license number ',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: vechilenumberController,
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when focused
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when not focused
                  ),
                ),
                labelText: 'Enter your vechile number ',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          TextField(
            controller: vechilemodelController,
            style: TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when focused
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white, // Border color when not focused
                  ),
                ),
                labelText: 'Enter your model ',
                labelStyle: TextStyle(color: Colors.white)
            ),
          ),
          SizedBox(height: 15,),
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("License Front",style: TextStyle(color: Colors.white),),	
          licensefront==null?Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: IconButton(
              onPressed: () async {
                Uint8List img = await pickImage(ImageSource.gallery);
                setState(() {
                  licensefront = img;
                });
              },
              icon: Icon(Icons.add),
            ),
          ):Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Image.memory(licensefront!),
          ),],),
          SizedBox(height: 15,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("License Back",style: TextStyle(color: Colors.white),),
          licenseback==null?Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: IconButton(
              onPressed: (){
                pickImage(ImageSource.gallery).then((img){
                  setState(() {
                    licenseback = img;
                  });
                });
              },
              icon: Icon(Icons.add),
            ),
          ):Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Image.memory(licenseback!),
          ),],),
          SizedBox(height: 15,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Citizenship Front",style: TextStyle(color: Colors.white),),
          citizenshipfront==null?Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: IconButton(
              onPressed: (){
                pickImage(ImageSource.gallery).then((img){
                  setState(() {
                    citizenshipfront = img;
                  });
                });
              },
              icon: Icon(Icons.add),
            ),
          ):Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Image.memory(citizenshipfront!),
          ),],),
          SizedBox(height: 15,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Citizenship Back",style: TextStyle(color: Colors.white),),
          citizenshipback==null?Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: IconButton(
              onPressed: (){
                pickImage(ImageSource.gallery).then((img){
                  setState(() {
                    citizenshipback = img;
                  });
                });
              },
              icon: Icon(Icons.add),
            ),
          ):Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Image.memory(citizenshipback!),
          ),],),
          SizedBox(height: 15,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [ Text("Vechile 1",style: TextStyle(color: Colors.white),),
          vechile1==null?Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: IconButton(
              onPressed: (){
                pickImage(ImageSource.gallery).then((img){
                  setState(() {
                    vechile1 = img;
                  });
                });
              },
              icon: Icon(Icons.add),
            ),
          ):Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Image.memory(vechile1!),
          ),],),
          SizedBox(height: 15,),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Text("Vechile 2",style: TextStyle(color: Colors.white),),
          vechile2==null?Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: IconButton(
              onPressed: (){
                pickImage(ImageSource.gallery).then((img){
                  setState(() {
                    vechile2 = img;
                  });
                });
              },
              icon: Icon(Icons.add),
            ),
          ):Container(
            width: 50,
            height: 50,
            color: Colors.white,
            child: Image.memory(vechile2!),
          ),],),
          SizedBox(height: 15,),
          ElevatedButton(
            onPressed: () async {
              String? lf= licensefront!=null?base64Encode(licensefront!):null;
              String? lb= licenseback!=null?base64Encode(licenseback!):null;
              String? cf= citizenshipfront!=null?base64Encode(citizenshipfront!):null;
              String? cb= citizenshipback!=null?base64Encode(citizenshipback!):null;
              String? v1= vechile1!=null?base64Encode(vechile1!):null;
              String? v2= vechile2!=null?base64Encode(vechile2!):null;
              var data ={
                "citizenshipnumber": citizenshipnumberController.text,
                "licensenumber": licensenumberController.text,
                "vechilenumber": vechilenumberController.text,
                "vechilemodel": vechilemodelController.text,
                "licensefront": lf,
                "licenseback": lb,
                "citizenshipfront": cf,
                "citizenshipback": cb,
                "vehicle1": v1,
                "vehicle2": v2
              };
              
              var response = await user.documents(data);
              if(response['success']){
                Navigator.pushReplacementNamed(context, '/dashboard');
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response['message'])));
              }
            },
            child: Text("Submit"),
          )

          ],
        ),
      ),
    );
  }
}