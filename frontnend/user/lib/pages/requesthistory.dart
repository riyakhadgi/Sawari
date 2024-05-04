import'package:flutter/material.dart';
import 'package:user/Controller/BookingController.dart';
class requesthistory extends StatefulWidget {
  const requesthistory({super.key});

  @override
  State<requesthistory> createState() => _requesthistoryState();
}

class _requesthistoryState extends State<requesthistory> {
  bool isLoading=true;
  Book book= Book();

  @override
  void initState() {
    super.initState();
    _getData();
  }
  Future<void> _getData() async{
    var response= await book.bookinghistory();
    print(response);
    setState(() {
      isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My rides"),
        centerTitle: true,
      ),
      body: isLoading ? CircularProgressIndicator() : body(),
    );
  }

  Widget body(){
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Text("hi"),
          ],
        ),
      ),
    );
  }
}
