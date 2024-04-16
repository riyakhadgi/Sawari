import 'package:flutter/material.dart';

void showWaitingModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (context) {
      return Stack(
        alignment: Alignment.center,
        children: [
          // Background content
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5), // Semi-transparent black color
            ),
          ),

          // Modal content
          Container(
            height: 200,
            color: Colors.blue,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinearProgressIndicator(),
                SizedBox(height: 16), // Spacer
                Text("Searching Driver",style: TextStyle(fontSize: 20,color: Colors.white),),
                SizedBox(height: 16), // Spacer
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the modal
                  },
                  child: Text("Cancel"),
                ),
              ],
            ),
          ),
        ],
      );
    },
  );
}