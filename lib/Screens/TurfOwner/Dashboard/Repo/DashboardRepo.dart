import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class DashboardRepo {
  static Future<List> uploadTurfImage(List imagesPath) async {
    List TurfImages = [];
    try {
      Reference ref = FirebaseStorage.instance.ref();
      Reference root = ref.child("TurfImages");
      final metadata = SettableMetadata(contentType: "image/jpeg");

      for (var i = 0; i < imagesPath.length; i++) {
        var imagePath = imagesPath[i]
            .toString()
            .substring(7, imagesPath[i].toString().length - 1);

        var uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
        Reference child = root.child(uniqueName);

        await child.putFile(File(imagePath), metadata);
        var imageUrl = await child.getDownloadURL();
        print(imageUrl);
        TurfImages.add(imageUrl);
      }
      return TurfImages;
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<String> uploadTurfLogo(logoPath) async {
    try {
      final metedata = SettableMetadata(contentType: "image/jpeg/jpg");
      final uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref();
      Reference root = ref.child("TurfLogo");
      Reference child = root.child(uniqueName);

      await child.putFile(File(logoPath), metedata);
      return await child.getDownloadURL();
    } catch (e) {
      print(e);
    }
    return "";
  }

  static Future<bool> turfInfoSendToDb(turfInfo) async {
    print(turfInfo);
    try {
      var response = await http.post(
          Uri.parse("http://192.168.201.236:5000/addTurf"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(turfInfo));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["acknowledged"] == true) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
