import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
// import 'package:path_provider/path_provider.dart';

class QuestionPagesforStudents extends StatefulWidget {
  const QuestionPagesforStudents({super.key});

  @override
  State<QuestionPagesforStudents> createState() =>
      _QuestionPagesforStudentsState();
}

class _QuestionPagesforStudentsState extends State<QuestionPagesforStudents> {
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

  // to download file use ref stored in firebase
  // Future downloadFile(Reference ref) async {
  //   try {
  //     final url = await ref.getDownloadURL();
  //     final tempdir = await getTemporaryDirectory();
  //     final path = File('${tempdir.path}/${ref.name}');
  //     var dir = await DownloadsPathProvider.downloadsDirectory;
  //     // needs to fixed
  //     setState(() {
  //       savename = 'file ${index + 1}.pdf';
  //       //print(pickedFile?.name.toString());
  //     });
  //     String savePath = dir!.path + "/${savename}";
  //     await Dio().download(url, savePath);
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Download ${ref.name}'),
  //       ),
  //     );
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void feedBack() {}

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
                            //onPressed: () => downloadFile(file),
                            onPressed: () {},
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
        onPressed: feedBack,
        child: const Icon(Icons.feedback_outlined),
      ),
    );
  }
}
