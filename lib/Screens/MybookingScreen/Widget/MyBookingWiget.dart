import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/MyBookingDetailsScreen/Ui/MyBookingDetailsScreen.dart';

class MyBookingWidget extends StatelessWidget {
  final allBookings;
  MyBookingWidget({super.key, required this.allBookings});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: allBookings.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: screenWidth,
          height: 150,
          child: Card(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: screenWidth * 0.25,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(allBookings[index].turfLogo),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: allBookings[index].turfName,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          TextWidget(
                            text: allBookings[index].date,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: screenWidth * 0.7,
                        child: Divider(
                          thickness: 2,
                        )),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: "Booking Event :",
                            fontWeight: FontWeight.w500,
                          ),
                          TextWidget(
                            text: allBookings[index].eventName,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: screenWidth * 0.7,
                        child: Divider(
                          thickness: 2,
                        )),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: "Time Slot :",
                            fontWeight: FontWeight.w500,
                          ),
                          TextWidget(
                            text: allBookings[index].slot,
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        width: screenWidth * 0.7,
                        child: Divider(
                          thickness: 2,
                        )),
                    SizedBox(
                      width: screenWidth * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: 'BDT:${allBookings[index].totalPrice}',
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            width: 100,
                            height: 20,
                            child: ButtonWidget(
                                callback: () {
                                  PersistentNavBarNavigator
                                      .pushNewScreenWithRouteSettings(
                                    context,
                                    settings: RouteSettings(name: ""),
                                    screen: MyBookingDetailsScreen(
                                        bookingDetails: allBookings[index]),
                                    withNavBar: false,
                                    pageTransitionAnimation:
                                        PageTransitionAnimation.cupertino,
                                  );
                                },
                                text: "see more"),
                          )
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
    ;
  }
}
