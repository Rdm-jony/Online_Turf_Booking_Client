import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:playspot_client/Screens/MybookingScreen/Model/MybookingModel.dart';
import 'package:http/http.dart' as http;

class BookedTurfRepo {
  static Future<List<MybookingModel>> fatchAllBooking() async {
    print("kjgk");
    try {
      List<MybookingModel> allBookings = [];
      var email = FirebaseAuth.instance.currentUser?.email;

      var response = await http.get(Uri.parse(
          "https://play-spot-git-main-rdm-jony.vercel.app/booked/${email}"));
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          MybookingModel book = MybookingModel.fromJson(jsonResponse[i]);
          allBookings.add(book);
        }

        return allBookings;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
