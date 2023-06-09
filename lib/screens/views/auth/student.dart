import 'package:clg_project/screens/pagesforstudent/home.dart';
import 'package:clg_project/screens/pagesforstudent/questionpagesForStudents.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../pagesforstudent/explore.dart';
import '../../../widgets/bottonForStudent.dart';

import '../signout/signOut.dart';
import 'login.dart';

class Student extends StatefulWidget {
  String text;
  Student({required this.text});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  int _selectIndex = 0;
  void navigatorBottomBar(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  //pages to display
  List<Widget> _pages = [
    Home(),
    ExplorePage(),
    QuestionPagesforStudents(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavForStudent(
          selectedTab: (index) => navigatorBottomBar(index)),
      appBar: AppBar(
        title: Text(
          // _pages[_selectIndex].toString(),
          widget.text,
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
      ),
      body: _pages[_selectIndex],
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }
}
