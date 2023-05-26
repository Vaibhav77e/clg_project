import 'package:clg_project/testpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../adminpages/notespape.dart';
import '../../../adminpages/questionpaper.dart';
import '../../../adminpages/reportPage.dart';
import '../../../adminpages/studentDetail.dart';
import '../../../widgets/bottonav.dart';
import '../signout/signOut.dart';
import 'login.dart';

class Teacher extends StatefulWidget {
  const Teacher({super.key});

  @override
  State<Teacher> createState() => _TeacherState();
}

class _TeacherState extends State<Teacher> {
  int _selectIndex = 0;
  void navigatorBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  //pages to display
  List<Widget> _pages = [
    StudentDetails(),
    NotesPage(),
    QuestionPages(),
    ReportPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNav(selectedTab: (index) => navigatorBottomBar(index)),
      appBar: AppBar(
        title: Text(
          _pages[_selectIndex].toString(),
          style: const TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: CircleAvatar(
            // radius: ,
            child: IconButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Signout(),
                      ),
                    ),
                icon: const Icon(
                  Icons.person,
                  color: Colors.black,
                )),
          ),
        ),
        actions: [
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(
          //           MaterialPageRoute(builder: (context) => ReportPage()));
          //     },
          //     icon: const Text('View Report')),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => TestPage()));
              },
              icon: const Text('View Report')),
        ],
      ),
      body: _pages[_selectIndex],
    );
  }
}
