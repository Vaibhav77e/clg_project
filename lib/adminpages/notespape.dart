import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class NotesPage extends StatefulWidget {
  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
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

  // Future<void> downloadFile() async {
  //   // final FirebaseStorage ref =
  //   //     FirebaseStorage.instance.ref('notes.pdf') as FirebaseStorage;
  //   // final firebase_storage.Reference ref = firebase_storage
  //   //     .FirebaseStorage.instance
  //   //     .ref('panduan/Pedoman_pemantauan.pdf');

  //   final Directory appDocDir = await getApplicationDocumentsDirectory();
  //   final String appDocPath = appDocDir.path;
  //   final File tempFile = File(appDocPath + '/' + 'Pedoman_Pemantauan.pdf');
  //   try {
  //     //await ref.writeToFile(tempFile);
  //     await tempFile.create();
  //     await OpenFile.open(tempFile.path);
  //   } on FirebaseException {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //           'Error, file tidak bisa diunduh',
  //           style: Theme.of(context).textTheme.bodyText1,
  //         ),
  //       ),
  //     );
  //   }
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //         content: Text(
  //           'File Berhasil diunduh',
  //           style: Theme.of(context).textTheme.bodyText1,
  //         ),
  //         behavior: SnackBarBehavior.floating,
  //         backgroundColor: Theme.of(context).primaryColorLight,
  //         shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(30.0))),
  //   );
  // }

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
      String savename = "file.pdf";
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
                  return ListTile(
                    title: Text(file.name),
                    trailing: IconButton(
                        onPressed: () => downloadFile(file),
                        icon: const Icon(Icons.download)),
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

// Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8.0),
//         child: Column(children: [
//           const SizedBox(
//             height: 20,
//           ),
//           const Text(
//             '8th sem notes',
//             style: TextStyle(fontSize: 20),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           ElevatedButton(
//               onPressed: uploadFile, child: const Text('Upload file')),
//           ElevatedButton(
//               onPressed: selectFile, child: const Text('select file')),
//           // Text(pickedFile!.name.toString())
//           Container(),
//           // failed attempt
//           ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 primary: Theme.of(context).buttonColor,
//                 shadowColor: Theme.of(context).shadowColor,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//               ),
//               onPressed: () async {
//                 await downloadFile();
//               },
//               child: Text(
//                 "Unduh Panduan",
//                 style: Theme.of(context).textTheme.button!.copyWith(
//                       color: Theme.of(context).scaffoldBackgroundColor,
//                     ),
//               )),
//         ]),
//       ),
