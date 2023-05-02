import 'package:flutter/material.dart';

class Alert extends StatelessWidget {
  final String text;
  //final String content;
  Alert({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(text),
    );
  }
}
