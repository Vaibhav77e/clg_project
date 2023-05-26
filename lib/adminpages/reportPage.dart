import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:io';

import 'package:dio/dio.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  // Initial Selected Value
  String dropdownvalue = 'Select subject';
  String dropdownvalueS = 'Select class';
  String dropdownvalueI = 'Select Exam';

  late Future<ListResult> futureFilesDownlod;

  //List<Reference> files = [];

  String savename = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFilesDownlod =
        FirebaseStorage.instance.ref('/internals/Ns 1 internal').listAll();
  }

  // List of items in our dropdown menu
  var items = [
    'Select subject',
    'Network Security',
  ];

  var classStudent = [
    'Select class',
    '8th sem',
  ];

  var internals = [
    'Select Exam',
    'First Internals',
    'Second Internals',
    'Third Internals',
  ];

  Future downloadFile(Reference ref) async {
    try {
      final url = await ref.getDownloadURL();
      final tempdir = await getTemporaryDirectory();
      // ignore: unused_local_variable
      final path = File('${tempdir.path}/${ref.name}');
      var dir = await DownloadsPathProvider.downloadsDirectory;

      // needs to fixed
      setState(() {
        savename = 'report.pdf';
      });
      String savePath = "${dir!.path}/$savename";
      await Dio().download(url, savePath);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download ${ref.name}'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Get Report')),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: FutureBuilder<ListResult>(
            future: futureFilesDownlod,
            builder: (context, snapshot) {
              try {
                if (snapshot.hasData) {
                  final files = snapshot.data!.items;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          }),
                      DropdownButton(
                          value: dropdownvalueS,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: classStudent.map((String classStudent) {
                            return DropdownMenuItem(
                              value: classStudent,
                              child: Text(classStudent),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalueS = newValue!;
                            });
                          }),
                      DropdownButton(
                          value: dropdownvalueI,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: internals.map((String internals) {
                            return DropdownMenuItem(
                              value: internals,
                              child: Text(internals),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalueI = newValue!;
                            });
                          }),
                      ElevatedButton(
                          onPressed: () => downloadFile(files as Reference),
                          child: const Text('Download Report'))
                    ],
                  );
                }
              } catch (e) {
                print(e.toString());
              }
              return const Center(child: CircularProgressIndicator());
            }),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //     onPressed: () => downloadFile(files as Reference),
      //     label: const Text('Download Report')),
    );
  }
}
