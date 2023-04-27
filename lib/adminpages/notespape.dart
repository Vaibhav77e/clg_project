import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../models/subject.dart';
import '../reuableWidget/subjectWidget.dart';

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  //List<Subject> subjectList=[];
  final String assetName = 'assets/YIt_2.svg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: SubjectWidget(),
      ),
    ));
  }
}
