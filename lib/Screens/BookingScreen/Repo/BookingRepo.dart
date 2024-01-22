import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class BookingRepo {
  static Future<List> startTimeList(List clockTime) async {
    try {
      var list = [];
      for (var i = 0; i < clockTime.length; i++) {
        var startTime = clockTime[i].toString().split("-");
        var endTime = clockTime[i].toString().split("-");

        DateTime startTimeClock =
            DateFormat('h:ma').parse(startTime[0].replaceAll(" ", ""));
        DateTime endtTimeClock =
            DateFormat('h:ma').parse(endTime[1].replaceAll(" ", ""));
        // List of start Time:

        var interval = Duration(minutes: 60);
        list.add(DateFormat('hh:mm a').format(startTimeClock));
        while (startTimeClock.millisecondsSinceEpoch <
            endtTimeClock.millisecondsSinceEpoch) {
          startTimeClock = startTimeClock.add(interval);
          var time = DateFormat('hh:mm a').format(startTimeClock);
          list.add(time);
        }

        list.removeLast();
      }
      return list;
    } catch (e) {}
    return [];
  }

  static Future<List> endTimeList(List clockTime, String fromTime) async {
    try {
      var list = [];
      for (var i = 0; i < clockTime.length; i++) {
        var startTime = clockTime[i].toString().split("-");
        var endTime = clockTime[i].toString().split("-");

        DateTime startTimeClock =
            DateFormat('h:ma').parse(startTime[0].replaceAll(" ", ""));
        DateTime endtTimeClock =
            DateFormat('h:ma').parse(endTime[1].replaceAll(" ", ""));

        DateTime selectTime =
            DateFormat('h:ma').parse(fromTime.replaceAll(" ", ""));

        if ((selectTime.isAfter(startTimeClock) ||
                selectTime == startTimeClock) &&
            selectTime.isBefore(endtTimeClock)) {
          var selectTimeRange = clockTime[i].toString().split(",");
          DateTime startTimeClock =
              DateFormat('h:ma').parse(startTime[0].replaceAll(" ", ""));
          DateTime endtTimeClock =
              DateFormat('h:ma').parse(endTime[1].replaceAll(" ", ""));
          // List of start Time:

          var interval = Duration(minutes: 60);
          list.add(DateFormat('hh:mm a').format(startTimeClock));
          while (startTimeClock.millisecondsSinceEpoch <
              endtTimeClock.millisecondsSinceEpoch) {
            startTimeClock = startTimeClock.add(interval);
            var time = DateFormat('hh:mm a').format(startTimeClock);

            list.add(time);
          }

          list = list.sublist(list.indexOf(fromTime) + 1, list.length);

          return list;
        }
      }
    } catch (e) {}
    return [];
  }

  static Future<String> totalPriceForSlot(List timeSlot, price) async {
    try {
      DateTime fromTime =
          DateFormat("h:ma").parse(timeSlot[0].toString().replaceAll(" ", ""));
      DateTime toTime =
          DateFormat("h:ma").parse(timeSlot[1].toString().replaceAll(" ", ""));
      int dif = toTime.difference(fromTime).inHours;
      var totalPrice = dif * double.parse(price);
      return totalPrice.toStringAsFixed(2);
    } catch (e) {}
    return "";
  }

  static Future<String> bookingInfoToDb(Map bookingInfo) async {
    try {
      // var bookingInfo{}
      var response = await http.post(
          Uri.parse("http://192.168.201.236:5000/bookings"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(bookingInfo));

      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        return jsonReponse["url"];
      }
    } catch (e) {}
    return "";
  }

  static Future<List> fetchAvailableTimeSlot(
      date, turfId, eventName, weekday) async {
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.201.236:5000/bookings/${date}?turfId=${turfId}&eventName=${eventName}&weekday=${weekday}"));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse;
      }
    } catch (e) {}
    return [];
  }
}
