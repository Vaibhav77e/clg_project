import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';

class QuestionPages extends StatefulWidget {
  @override
  State<QuestionPages> createState() => _QuestionPagesState();
}

class _QuestionPagesState extends State<QuestionPages> {
  int index = 0;
  String savename = '';
  late Future<ListResult> futureFiles;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/notes').listAll();
  }

  TextEditingController fileName = TextEditingController();
  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  Future selectFile() async {
    final res = await FilePicker.platform.pickFiles();
    if (res == null) return;
    setState(() {
      pickedFile = res.files.first;
    });
  }

  Future uploadFile() async {
    final path = 'notes/${pickedFile!.name}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    // final snapshot = await uploadTask!.whenComplete(() {});

    // final urlDownload = await snapshot.ref.getDownloadURL();
    // print('Download Link : $urlDownload');
  }

  // to download file use ref stored in firebase
  Future downloadFile(Reference ref) async {
    try {
      ////-----------only visibile to app not to user -------//////////
      // // not visible to user download and save using path provider packages
      // final dir =
      //     await getApplicationDocumentsDirectory(); // only visible to app not the user

      // final file = File('${dir.path}/${ref.name}');
      // await ref.writeToFile(file);

      ////-----------for to make visible to user -------//////////
      final url = await ref.getDownloadURL();
      final tempdir = await getTemporaryDirectory();
      final path = File('${tempdir.path}/${ref.name}');
      var dir = await DownloadsPathProvider.downloadsDirectory;
      // needs to fixed
      setState(() {
        savename = 'file ${index + 1}.pdf';
        //print(pickedFile?.name.toString());
      });
      String savePath = dir!.path + "/${savename}";
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
      body: FutureBuilder<ListResult>(
        future: futureFiles,
        builder: (context, snapshot) {
          try {
            if (snapshot.hasData) {
              final files = snapshot.data!.items;
              return ListView.builder(
                itemCount: files.length,
                itemBuilder: (context, index) {
                  final file = files[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade400,
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(file.name),
                        trailing: IconButton(
                            onPressed: () => downloadFile(file),
                            icon: const Icon(Icons.download)),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return const Center(child: Text('An error occured'));
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          } catch (e) {
            print(e.toString());
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: selectFile,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
