import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class NavbarRepo {
  static Future<String> fatchUserRole() async {
    try {
      var email = FirebaseAuth.instance.currentUser?.email;
      var response = await http
          .get(Uri.parse("http://192.168.201.236:5000/userRole/${email}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);

        return jsonResponse["role"];
      }
    } catch (e) {}
    return "";
  }
}
