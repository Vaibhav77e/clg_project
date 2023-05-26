import 'dart:convert';

import 'package:clg_project/adminpages/newREportPage.dart';
import 'package:clg_project/models/studentDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StudentDetails extends StatefulWidget {
  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  Future<List<StudentDetailsModel>> stupidDataa() async {
    final respone = await http
        .get(Uri.parse('http://www.greedandfear.fun:9999/api/student-list/'));
    if (respone.statusCode == 200) {
      final List reu = json.decode(respone.body);
      return reu.map((e) => StudentDetailsModel.fromJson(e)).toList();
    } else {
      throw Exception("couldn't fetch data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<StudentDetailsModel>>(
          future: stupidDataa(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Padding(
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
                                'Student Name : ${snapshot.data![index].name} ',
                                style: const TextStyle(fontSize: 18),
                              ),
                              const CircleAvatar(
                                radius: 5,
                                backgroundColor: Colors.green,
                              ),
                            ],
                          ),
                          Text(
                            'USN : ${snapshot.data![index].usn}',
                            style: const TextStyle(fontSize: 18),
                          ),
                          Text(
                            'UId : ${snapshot.data![index].student_id}',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => NewReport()));
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        label: const Text('View Report'),
      ),
    );
  }
}

// class StudentDetailsModel {
//   String? student_id;
//   String? name;
//   String? usn;
//   String? phoneum;

//   StudentDetailsModel(
//       {required this.student_id,
//       required this.name,
//       required this.usn,
//       required this.phoneum});

//   StudentDetailsModel.fromJson(Map<String, dynamic> json) {
//     student_id = json['student_id'];
//     name = json['name'];
//     usn = json['usn'];
//     phoneum = json['phonenum'].toString();
//   }
// }
