import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final FirebaseStorage storage = FirebaseStorage.instance;

  Future<String> downloadURL(String imageName) async {
    String downloadURL = "";
    try {
      downloadURL = await storage.ref('images/$imageName').getDownloadURL();
    } on FirebaseException catch (error) {
      print(error);
    }

    return downloadURL;
  }
}
