import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
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

  Future<String> downloadPDF(String pdfName) async {
    String downloadURL = "";
    try {
      downloadURL = await storage.ref('files/$pdfName').getDownloadURL();
    } on FirebaseException catch (error) {
      print(error);
    }
    return downloadURL;
  }

  Future<Uint8List?> downloadPDF2(String pdfName) async {
    Uint8List? data;
    try {
      data = await storage.ref('files/$pdfName').getData(10485760);
    } on FirebaseException catch (error) {
      print(error);
    }
    return data;
  }
}
