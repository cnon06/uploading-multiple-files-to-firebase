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
  // double? _progress;
  // UploadTask? uploadTask;

  // void singleFile() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles();

  //   if (result != null) {
  //     File file = File(result.files.single.path!);

  //     setState(() {
  //       fileString = result.files.single.path!.toString();
  //       //fileExtension = result.files.single.extension!.toString();
  //       fileName = result.files.single.name.toString();
  //       print(fileName);
  //       // OpenFile.open(fileString);
  //       final ref = FirebaseStorage.instance.ref().child(fileName);
  //       uploadTask = ref.putFile(file);

  //       uploadTask!.snapshotEvents.listen((event) {
  //         setState(() {
  //           _progress =
  //               event.bytesTransferred.toDouble() / event.totalBytes.toDouble();
  //           print(_progress.toString());
  //         });
  //         if (event.state == TaskState.success) {
  //           _progress = null;
  //           print(_progress);
  //           //Fluttertoast.showToast(msg: 'File added to the library');
  //         }
  //       }).onError((error) {
  //         // do something to handle error
  //       });
  //     });
  //   } else {
  //     fileString = "User canceled the picker.";
  //     // User canceled the picker
  //   }
  // }

  List<File>? files;

  void singleFile() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      files = result.paths.map((path) => File(path!)).toList();

      for (var file1 in files!) {
        // print(file1);
        // String file2 = file1.path;
        //file2.lastIndexOf("/");
        String fileName =
            file1.path.toString().substring(file1.path.lastIndexOf("/") + 1);
        print(fileName);
        final ref = FirebaseStorage.instance.ref().child(fileName);
         ref.putFile(file1);
      }
    } else {}

    setState(() {});
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
            // _progress != null
            //     ? CircularProgressIndicator(
            //         value: _progress, //controller.value,
            //         semanticsLabel: 'Linear progress indicator',
            //       )
            //     : const SizedBox(height: 10),
            // Text("Progress: $_progress"),
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
