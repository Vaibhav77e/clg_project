import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class StudentDetails extends StatefulWidget {
  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  String name = '';

  String usn = '';

  String rfid = '';
  String formatted = '';

  void checkDate() async {
    try {
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2060))
          .then((value) {
        setState(() {
          // dateTime = value;
          final DateFormat formatter = DateFormat('yyyy-MM-dd');
          formatted = formatter.format(value!);
        });
      });
      // dateTime = formatted as DateTime?;
      print(formatted);

      const url =
          'http://www.greedandfear.fun:9999/api/get-attendance-by-date/';
      var response = await http.post(Uri.parse(url),
          body: {"start_date": "2023-05-21", "end_date": formatted});
      var responseData = json.decode(response.body);
      print(responseData);
    } catch (e) {
      print(e.toString());
    }
  }

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
                    ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: checkDate,
        child: const Icon(Icons.get_app),
      ),
    );
  }
}
