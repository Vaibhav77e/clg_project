import 'dart:convert';

import 'package:clg_project/models/studentDetails.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class StudentDetails extends StatefulWidget {
  @override
  State<StudentDetails> createState() => _StudentDetailsState();
}

class _StudentDetailsState extends State<StudentDetails> {
  List student = [
    {
      "student_id": "13AD1015",
      "name": "Johnsnon",
      "usn": "4DM19EC036",
      "phonenum": 7899404714
    },
    {
      "student_id": "1CF3349",
      "name": "Varun",
      "usn": "4DM19EC049",
      "phonenum": 9663863498
    },
    {
      "student_id": "73ADF214",
      "name": "Manjunath",
      "usn": "4DM19EC018",
      "phonenum": 7022820251
    },
    {
      "student_id": "9C604F4A",
      "name": "Vaibhav",
      "usn": "4DM19EC047",
      "phonenum": 7348849521
    },
    {
      "student_id": "1",
      "name": "Muffed",
      "usn": "4DM19EC001",
      "phonenum": 111111111
    },
    {
      "student_id": "2",
      "name": "Sinan",
      "usn": "4DM19EC002",
      "phonenum": 111111111
    },
    {
      "student_id": "3",
      "name": "Abhishek",
      "usn": "4DM19EC003",
      "phonenum": 111111111
    },
    {
      "student_id": "4",
      "name": "Sudhi",
      "usn": "4DM19EC004",
      "phonenum": 111111111
    },
    {
      "student_id": "5",
      "name": "Anush",
      "usn": "4DM19EC005",
      "phonenum": 111111111
    },
    {
      "student_id": "6",
      "name": "Ashwitha",
      "usn": "4DM19EC006",
      "phonenum": 111111111
    },
    {
      "student_id": "7",
      "name": "Aslam",
      "usn": "4DM19EC007",
      "phonenum": 111111111
    },
    {
      "student_id": "8",
      "name": "ayesha",
      "usn": "4DM19EC008",
      "phonenum": 111111111
    },
    {
      "student_id": "9",
      "name": "Chandu",
      "usn": "4DM19EC009",
      "phonenum": 111111111
    },
    {
      "student_id": "10",
      "name": "Deepak",
      "usn": "4DM19EC010",
      "phonenum": 111111111
    },
    {
      "student_id": "11",
      "name": "Fathima",
      "usn": "4DM19EC011",
      "phonenum": 111111111
    },
    {
      "student_id": "12",
      "name": "Gangu",
      "usn": "4DM19EC012",
      "phonenum": 111111111
    },
    {
      "student_id": "13",
      "name": "Joswy",
      "usn": "4DM19EC013",
      "phonenum": 111111111
    },
    {
      "student_id": "14",
      "name": "Kruthi",
      "usn": "4DM19EC014",
      "phonenum": 111111111
    },
    {
      "student_id": "15",
      "name": "Irfan",
      "usn": "4DM19EC015",
      "phonenum": 111111111
    },
    {
      "student_id": "16",
      "name": "Manoj",
      "usn": "4DM19EC016",
      "phonenum": 111111111
    },
    {
      "student_id": "17",
      "name": "Meghana",
      "usn": "4DM19EC017",
      "phonenum": 111111111
    },
    {
      "student_id": "19",
      "name": "Mirza",
      "usn": "4DM19EC019",
      "phonenum": 111111111
    },
    {
      "student_id": "20",
      "name": "Mishba",
      "usn": "4DM19EC020",
      "phonenum": 111111111
    },
    {
      "student_id": "21",
      "name": "Shabaz",
      "usn": "4DM19EC021",
      "phonenum": 111111111
    },
    {
      "student_id": "22",
      "name": "Mouna",
      "usn": "4DM19EC022",
      "phonenum": 111111111
    },
    {
      "student_id": "23",
      "name": "Naufal",
      "usn": "4DM19EC023",
      "phonenum": 111111111
    },
    {
      "student_id": "24",
      "name": "Nireeksha",
      "usn": "4DM19EC024",
      "phonenum": 111111111
    },
    {
      "student_id": "25",
      "name": "Pavan",
      "usn": "4DM19EC025",
      "phonenum": 111111111
    },
    {
      "student_id": "26",
      "name": "Anvitha",
      "usn": "4DM19EC026",
      "phonenum": 111111111
    },
    {
      "student_id": "27",
      "name": "Pooja",
      "usn": "4DM19EC027",
      "phonenum": 111111111
    },
    {
      "student_id": "28",
      "name": "Prajwal",
      "usn": "4DM19EC028",
      "phonenum": 111111111
    },
    {
      "student_id": "29",
      "name": "Raksith",
      "usn": "4DM19EC029",
      "phonenum": 111111111
    },
    {
      "student_id": "30",
      "name": "Ravi",
      "usn": "4DM19EC030",
      "phonenum": 111111111
    },
    {
      "student_id": "31",
      "name": "Reena",
      "usn": "4DM19EC031",
      "phonenum": 111111111
    },
    {
      "student_id": "32",
      "name": "Sahana",
      "usn": "4DM19EC032",
      "phonenum": 111111111
    },
    {
      "student_id": "33",
      "name": "sajna",
      "usn": "4DM19EC033",
      "phonenum": 111111111
    },
    {
      "student_id": "34",
      "name": "Sanddep",
      "usn": "4DM19EC034",
      "phonenum": 111111111
    },
    {
      "student_id": "35",
      "name": "Shraddha",
      "usn": "4DM19EC035",
      "phonenum": 111111111
    },
    {
      "student_id": "37",
      "name": "Shruthi",
      "usn": "4DM19EC037",
      "phonenum": 111111111
    },
    {
      "student_id": "38",
      "name": "Spoorthi",
      "usn": "4DM19EC038",
      "phonenum": 111111111
    },
    {
      "student_id": "39",
      "name": "Sreenath",
      "usn": "4DM19EC039",
      "phonenum": 111111111
    },
    {
      "student_id": "40",
      "name": "Sushanth",
      "usn": "4DM19EC040",
      "phonenum": 111111111
    },
    {
      "student_id": "41",
      "name": "Usha",
      "usn": "4DM19EC041",
      "phonenum": 111111111
    },
    {
      "student_id": "42",
      "name": "Vandana",
      "usn": "4DM19EC042",
      "phonenum": 111111111
    },
    {
      "student_id": "43",
      "name": "Veeksith",
      "usn": "4DM19EC043",
      "phonenum": 111111111
    },
    {
      "student_id": "44",
      "name": "Vikas",
      "usn": "4DM19EC044",
      "phonenum": 111111111
    },
    {
      "student_id": "45",
      "name": "Vinodraj",
      "usn": "4DM19EC045",
      "phonenum": 111111111
    },
    {
      "student_id": "46",
      "name": "Vishwas",
      "usn": "4DM19EC046",
      "phonenum": 111111111
    },
    {
      "student_id": "48",
      "name": "Zulkif",
      "usn": "4DM19EC048",
      "phonenum": 111111111
    },
    {
      "student_id": "50",
      "name": "Smitha",
      "usn": "4DM19EC050",
      "phonenum": 111111111
    },
    {
      "student_id": "51",
      "name": "Kaleem",
      "usn": "4DM19EC051",
      "phonenum": 111111111
    }
  ];

  StudentDetailsModel studentDetails = StudentDetailsModel(
    name: '',
    phoneum: '',
    student_id: '',
    usn: '',
  );

  // void checkDate() async {
  //   try {
  //     showDatePicker(
  //             context: context,
  //             initialDate: DateTime.now(),
  //             firstDate: DateTime(2000),
  //             lastDate: DateTime(2060))
  //         .then((value) {
  //       setState(() {
  //         // dateTime = value;
  //         final DateFormat formatter = DateFormat('yyyy-MM-dd');
  //         formatted = formatter.format(value!);
  //       });
  //     });
  //     // dateTime = formatted as DateTime?;
  //     print(formatted);

  //     const url = 'http://www.greedandfear.fun:9999/api/student-list/';
  //     var response = await http.get(
  //       Uri.parse(url),
  //     );
  //     var responseData = json.decode(response.body);
  //     print(responseData);
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void getDataFromApi() async {
    try {
      const url = 'http://www.greedandfear.fun:9999/api/student-list/';
      var response = await http.get(
        Uri.parse(url),
      );
      var responseData = json.decode(response.body);
      print(responseData);
      studentDetails = StudentDetailsModel(
        student_id: responseData['student_id'],
        name: responseData['name'],
        phoneum: responseData['phoneum'],
        usn: responseData['usn'],
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: student.length,
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
                        'Student Name : ${student[index]['name']} ',
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
                    'USN : ${student[index]['usn']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    'UId : ${student[index]['student_id']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  // ElevatedButton(
                  //     onPressed: getDataFromApi, child: const Text('Get value'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
