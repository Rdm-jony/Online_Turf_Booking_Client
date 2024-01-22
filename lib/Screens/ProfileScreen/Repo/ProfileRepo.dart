import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;

class ProfileRepo {
  static Future<Map> fatchProfileInfo() async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email;
      var response = await http
          .get(Uri.parse("http://192.168.201.236:5000/users/${email}"));
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
          Uri.parse("http://192.168.201.236:5000/user/photo/${email}"),
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
