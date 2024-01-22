import 'dart:convert';

import 'package:playspot_client/Screens/SpotsScreen/Model/SpotsTurfModel.dart';
import 'package:http/http.dart' as http;

class SpotScreenRepo {
  static Future<List<SpotsTurfModel>> fatchAllTurf(division) async {
    try {
      List<SpotsTurfModel> allSpots = [];
      var response = await http.get(Uri.parse(
          "http://192.168.201.236:5000/allSpots?division=${division}"));

      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          SpotsTurfModel spot = SpotsTurfModel.fromJson(jsonResponse[i]);
          allSpots.add(spot);
        }
        return allSpots;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<SpotsTurfModel>> filteringAllSpots(eventName) async {
    try {
      List<SpotsTurfModel> allFilterSpot = [];
      var response = await http.get(Uri.parse(
          "http://192.168.201.236:5000/allSpots/filter?event=${eventName}"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          SpotsTurfModel spot = SpotsTurfModel.fromJson(jsonReponse[i]);
          allFilterSpot.add(spot);
        }
        return allFilterSpot;
      }
    } catch (e) {}
    return [];
  }

  static Future<List<SpotsTurfModel>> filteringAllSpotsByText(
      searchText) async {
    try {
      List<SpotsTurfModel> allFilterSpot = [];
      var response = await http.get(Uri.parse(
          "http://192.168.201.236:5000/allSpots/filterText?search=${searchText}"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          SpotsTurfModel spot = SpotsTurfModel.fromJson(jsonReponse[i]);
          allFilterSpot.add(spot);
        }
        return allFilterSpot;
      }
    } catch (e) {}
    return [];
  }
}
