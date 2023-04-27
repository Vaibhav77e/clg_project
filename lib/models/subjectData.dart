import 'package:flutter/material.dart';

import './subject.dart';
import 'package:provider/provider.dart';

class SubjectsProvider with ChangeNotifier {
  final List<Subject> _subjectData = [
    Subject(
        id: 1,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/04/13/16/09/pi-1327145__340.png',
        subjectCode: '18MAT31',
        scheme: '2018',
        subjectName: 'M3'),
    Subject(
        id: 2,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/04/13/16/09/pi-1327145__340.png',
        subjectCode: '18EC32',
        scheme: '2018',
        subjectName: 'Network Theory'),
    Subject(
        id: 3,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/04/13/16/09/pi-1327145__340.png',
        subjectCode: '18EC33',
        scheme: '2018',
        subjectName: 'Electronics Devices'),
  ];

  List<Subject> get subjectsData {
    return [..._subjectData];
  }
}
