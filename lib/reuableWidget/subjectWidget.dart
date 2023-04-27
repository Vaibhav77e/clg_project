import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SubjectWidget extends StatelessWidget {
  //final String assetName = 'assets/YIt_2.svg';
  final double id;
  final String imageUrl;
  final String subjectName;
  final String subjectCode;

  SubjectWidget(
      {required this.id,
      required this.subjectName,
      required this.subjectCode,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(top: 10),
        height: 150,
        width: 250,
        decoration: BoxDecoration(
            color: Colors.grey.shade400,
            image: DecorationImage(
              image: NetworkImage(imageUrl.toString()),
              fit: BoxFit.cover,
            ),
            border: Border.all(
              width: 3,
            ),
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    subjectName,
                    overflow: TextOverflow.fade,
                    maxLines: 1,
                    softWrap: false,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    subjectCode,
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
