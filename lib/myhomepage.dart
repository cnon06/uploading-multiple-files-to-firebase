import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String fileString = "";
  String fileName = "";

  void singleFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);

      setState(() {
        fileString = result.files.single.path!.toString();
        //fileExtension = result.files.single.extension!.toString();
        fileName = result.files.single.name.toString();
        print(fileName);
        // OpenFile.open(fileString);
        final ref = FirebaseStorage.instance.ref().child(fileName);
        ref.putFile(file);
      });
    } else {
      fileString = "User canceled the picker.";
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Home Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
                onPressed: () {
                  singleFile();
                },
                child: const Text("File")),
          ],
        ),
      ),
    );
  }
}
