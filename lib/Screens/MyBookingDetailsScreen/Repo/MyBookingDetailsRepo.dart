import 'dart:convert';

import 'package:http/http.dart' as http;

class MyBookingDetailsRepo {
  static Future<bool> sendFeedbackToDb(reviewInfo) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.201.236:5000/review"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reviewInfo));
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
