import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  static Future<Map> fatchProfileInfo() async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email;
      var response = await http.get(Uri.parse(
          "https://play-spot-git-main-rdm-jony.vercel.app/users/${email}"));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        return jsonReponse;
      }
    } catch (e) {}
    return {};
  }

  static Future<bool> uploadImageToDb(imageUrl) async {
    var user = FirebaseAuth.instance.currentUser;

    try {
      var email = user?.email;
      var response = await http.put(
          Uri.parse(
              "https://play-spot-git-main-rdm-jony.vercel.app/user/photo/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(imageUrl));

      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["acknowledged"] == true) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
