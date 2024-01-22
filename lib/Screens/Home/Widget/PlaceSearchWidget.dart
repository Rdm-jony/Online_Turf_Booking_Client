import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:sizer/sizer.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class PlaceSearchWidget extends StatefulWidget {
  final deviceLocation;
  final callbackForSerchLocation;
  PlaceSearchWidget(
      {super.key,
      required this.deviceLocation,
      required this.callbackForSerchLocation});

  @override
  State<PlaceSearchWidget> createState() => _PlaceSearchWidgetState();
}

class _PlaceSearchWidgetState extends State<PlaceSearchWidget> {
  TextEditingController _controller = TextEditingController();

  var uuId = Uuid();

  String sessionToken = "1234";
  List suggestionList = [];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: TextWidget(
          text: widget.deviceLocation,
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
      ),
      body: Column(children: [
        Row(
          children: [
            Icon(
              Icons.search,
              color: Colors.green,
            ),
            SizedBox(
              width: 90.w,
              child: TextFormField(
                controller: _controller,
                onChanged: (value) {
                  if (sessionToken == null) {
                    setState(() {
                      sessionToken = uuId.v4();
                    });
                  }
                  getSuggestion(_controller.text);
                },
                decoration: InputDecoration(hintText: "Serach your location"),
              ),
            )
          ],
        ),
        SizedBox(
          width: 100.w,
          height: 300,
          child: ListView.builder(
            itemCount: suggestionList.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: screenWidth * 0.85,
                      child: InkWell(
                        onTap: () {
                          widget.callbackForSerchLocation(
                              suggestionList[index]["description"]);
                          Navigator.pop(context);
                        },
                        child: TextWidget(
                            text: suggestionList[index]["description"]),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        )
      ]),
    );
  }

  void getSuggestion(String text) async {
    String apiKey = "AIzaSyCbPqlv5WSBwmMomlMHyWWLnTcFd6ZFk_E";
    String baseUrl =
        "https://maps.googleapis.com/maps/api/place/autocomplete/json";
    String requset =
        "${baseUrl}?input=${text}&key=${apiKey}&sessiontoken=${sessionToken}";
    var response = await http.get(Uri.parse(requset));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body.toString())["predictions"];
      setState(() {
        suggestionList = jsonResponse;
      });
    }
  }
}
