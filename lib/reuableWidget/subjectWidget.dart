import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubjectWidget extends StatelessWidget {
  final String assetName = 'assets/YIt_2.svg';
  const SubjectWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '3rd sem Notes',
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 180,
          child: Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 10),
                  height: 150,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        assetName,
                        semanticsLabel: 'Clg logo',
                        width: 130,
                        height: 130,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'subjectname',
                            style: TextStyle(fontSize: 17),
                          ),
                          Text(
                            'subjectcode',
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
