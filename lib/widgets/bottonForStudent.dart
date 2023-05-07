import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavForStudent extends StatelessWidget {
  void Function(int)? selectedTab;
  BottomNavForStudent({required this.selectedTab});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: GNav(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.all(22),
          color: Colors.black,
          activeColor: Colors.blueAccent,
          mainAxisAlignment: MainAxisAlignment.center,
          tabBackgroundColor: Colors.grey.shade400,
          //nothing change as per whati saw
          tabActiveBorder: Border.all(color: Colors.white),
          tabBorderRadius: 16,
          onTabChange: (val) => selectedTab!(val),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.explore,
              text: 'Explore',
            ),
            GButton(
              icon: Icons.question_answer,
              text: 'Question-Paper',
            ),
          ]),
    );
  }
}
