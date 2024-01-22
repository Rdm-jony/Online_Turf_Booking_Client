import 'dart:convert';

import 'package:playspot_client/Screens/Admin%20panel/AllUserScreen/Model/UserModel.dart';
import 'package:http/http.dart' as http;

class AllUserRepo {
  static Future<List<UserModel>> fatchAllUser() async {
    try {
      List<UserModel> allUser = [];
      var response =
          await http.get(Uri.parse("http://192.168.201.236:5000/alluser"));
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          UserModel user = UserModel.fromJson(jsonResponse[i]);
          allUser.add(user);
        }
        return allUser;
      }
    } catch (e) {}
    return [];
  }

  static Future<bool> setUserRole(userRole, email) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.201.236:5000/alluser/role/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"role": userRole}));
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
