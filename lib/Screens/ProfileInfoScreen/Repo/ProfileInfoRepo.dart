import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

var user = FirebaseAuth.instance.currentUser;

class ProfileInfoRepo {
  static Future<bool> updateUserInfoFunction(imagePath) async {
    try {
      // await user?.updatePhotoURL("https://example.com/jane-q-user/profile.jpg");
      final metadata = SettableMetadata(contentType: "image/jpeg");
      final uniqueName = DateTime.now().millisecondsSinceEpoch.toString() +
          user!.displayName.toString();
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImage = referenceRoot.child("profileImages");
      Reference referenceChildImage = referenceDirImage.child(uniqueName);

      await referenceChildImage.putFile(File(imagePath), metadata);
      var imageUrl = await referenceChildImage.getDownloadURL();
      await user?.updatePhotoURL(imageUrl);
      return true;
    } catch (e) {}
    return false;
  }

  static FutureOr<bool> sendUserInfoToDbFunction(userInfo) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var response = await http.put(
          Uri.parse("https://play-spot-git-main-rdm-jony.vercel.app/users"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userInfo));

      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["acknowledged"] == true) {
          await prefs.setBool("KEYLOGIN", true);

          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
