import 'package:flutter/material.dart';

class StudentDetails extends StatelessWidget {
  String name = '';
  String usn = '';
  String rfid = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          height: 150,
          width: 300,
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Student Name : $name ',
                      style: const TextStyle(fontSize: 18),
                    ),
                    // function to record whether to find is present
                    CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    )
                  ],
                ),
                Text(
                  'USN : $usn',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'UId : $rfid',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
