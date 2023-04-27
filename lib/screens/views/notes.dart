import 'package:flutter/material.dart';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';

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
  }

  // to download file use ref stored in firebase
  Future downloadFile(Reference ref) async {
    try {
      final url = await ref.getDownloadURL();
      final tempdir = await getTemporaryDirectory();
      final path = File('${tempdir.path}/${ref.name}');
      var dir = await DownloadsPathProvider.downloadsDirectory;
      // needs to fixed
      setState(() {
        savename = 'file ${index + 1}.pdf';
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
        onPressed: showDialogTile,
        child: const Icon(Icons.upload_file),
      ),
    );
  }
}
