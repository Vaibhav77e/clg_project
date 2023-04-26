import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  void Function()? onTap;
  String text;
  MyButton({required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 75,
          width: 400,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
          )),
    );
  }
}
