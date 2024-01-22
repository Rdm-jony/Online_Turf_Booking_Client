import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';

class PriceListWidget extends StatelessWidget {
  final event;
  PriceListWidget({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth,
      child: Column(
        children: [
          Container(
            width: screenWidth,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.green),
            child: Center(
                child: TextWidget(
              text: "Weekday",
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 18,
            )),
          ),
          
          SizedBox(
            width: screenWidth,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: event.weekdayTime.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: screenWidth * 0.6,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Center(
                          child: TextWidget(
                        text: event.weekdayTime[index],
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Center(
                          child: TextWidget(
                        text: 'bdt/= ${event.weekdayPrice}',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.green,
                      )),
                    )
                  ],
                );
              },
            ),
          ),
          Container(
            width: screenWidth,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.green),
            child: Center(
                child: TextWidget(
              text: "weekend",
              color: Color.fromRGBO(255, 255, 255, 1),
              fontSize: 18,
            )),
          ),
          SizedBox(
            width: screenWidth,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: event.weekendTime.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Container(
                      width: screenWidth * 0.6,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Center(
                          child: TextWidget(
                        text: event.weekendTime[index],
                        fontWeight: FontWeight.w500,
                      )),
                    ),
                    Container(
                      width: screenWidth * 0.4,
                      height: 50,
                      decoration: BoxDecoration(color: Colors.grey.shade300),
                      child: Center(
                          child: TextWidget(
                        text: 'bdt/= ${event.weekendPrice}',
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.green,
                      )),
                    )
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
