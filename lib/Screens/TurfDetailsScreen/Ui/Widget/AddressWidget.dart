import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/SpotsScreen/Model/SpotsTurfModel.dart';
import 'package:playspot_client/Screens/SpotsScreen/Widget/IconWidget.dart';

class AddressWidget extends StatelessWidget {
  int index = 1000;
  final Map turfDeteils;
  AddressWidget({super.key, required this.turfDeteils});

  @override
  Widget build(BuildContext context) {
    final screnWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        TextWidget(
          text: turfDeteils["name"],
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(
          width: screnWidth * 0.7,
          child: TextWidget(
            textAlign: TextAlign.center,
            text: turfDeteils["address"],
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 5,
        ),
        IconWidget(
          eventListIcon: turfDeteils["eventList"],
        ),
      ],
    );
  }
}
