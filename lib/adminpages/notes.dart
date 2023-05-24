import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:path_provider/path_provider.dart';

import 'package:percent_indicator/percent_indicator.dart';

class NotesView extends StatefulWidget {
  final String text;
  const NotesView({required this.text});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  int index = 0;
  String savename = '';
  late Future<ListResult> futureFiles;

  var isDownloadStarted = false;
  var isDownloadFinished = false;
  var downloadProgress = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FirebaseStorage.instance.ref('/${widget.text}').listAll();
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
    final path = '${widget.text}/${pickedFile!.name}';
    print(path);
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);
    Navigator.of(context).pop();
  }

  // to download file use ref stored in firebase
  Future downloadFile(Reference ref) async {
    try {
      isDownloadStarted = true;
      isDownloadFinished = false;
      downloadProgress = 0;
      setState(() {});

      final url = await ref.getDownloadURL();
      final tempdir = await getTemporaryDirectory();
      // ignore: unused_local_variable
      final path = File('${tempdir.path}/${ref.name}');
      var dir = await DownloadsPathProvider.downloadsDirectory;

      // needs to fixed
      setState(() {
        savename = 'file ${index + 1}.pdf';
        //savename = ' $ref.pdf';
      });
      String savePath = dir!.path + "/${savename}";
      await Dio().download(url, savePath);

      while (downloadProgress < 100) {
        downloadProgress += 10;
        setState(() {});
        if (downloadProgress == 100) {
          isDownloadFinished = true;
          isDownloadStarted = false;
          setState(() {});
          break;
        }
        await Future.delayed(const Duration(milliseconds: 500));
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Download ${ref.name}'),
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> showDialogTile() async {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('Select a file to server!!'),
              actions: [
                TextButton(
                  onPressed: selectFile,
                  child: const Text('choose'),
                ),
                TextButton(
                  onPressed: uploadFile,
                  child: const Text('upload'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.text),
      ),
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
                        // trailing: Column(
                        //   children: [
                        //     Visibility(
                        //       visible: isDownloadStarted,
                        //       child: CircularPercentIndicator(
                        //         radius: 20,
                        //         lineWidth: 3,
                        //         percent: (downloadProgress / 100),
                        //         center: Text(
                        //           '$downloadProgress%',
                        //           style: const TextStyle(
                        //               fontSize: 12, color: Colors.green),
                        //         ),
                        //         progressColor: Colors.green,
                        //       ),
                        //     ),
                        //     Visibility(
                        //       visible: !isDownloadStarted,
                        //       child: IconButton(
                        //           onPressed: () => downloadFile(file),
                        //           //onPressed: () {},
                        //           icon: const Icon(Icons.download)),
                        //     ),
                        //   ],
                        // ),

                        trailing: IconButton(
                            onPressed: () => downloadFile(file),
                            //onPressed: () {},
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
        onPressed: showDialogTile,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
