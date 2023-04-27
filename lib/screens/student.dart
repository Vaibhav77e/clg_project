import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../adminpages/notespape.dart';
import '../adminpages/questionpaper.dart';
import '../adminpages/studentDetail.dart';
import '../widgets/bottonav.dart';
import 'login.dart';

class Student extends StatefulWidget {
  const Student({super.key});

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
    StudentDetails(),
    NotesPage(),
    QuestionPages(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BottomNav(selectedTab: (index) => navigatorBottomBar(index)),
      appBar: AppBar(
        title: Text(
          _pages[_selectIndex].toString(),
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: CircleAvatar(
            // radius: ,
            child: IconButton(
                onPressed: () => logout(context),
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
