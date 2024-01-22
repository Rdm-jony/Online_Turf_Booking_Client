import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/BookingScreen/Ui/BookingScreen.dart';
import 'package:playspot_client/Screens/GoogleMapScreen/Ui/GoogleMapScreen.dart';
import 'package:playspot_client/Screens/PricingScreen/Ui/PricingScreen.dart';
import 'package:playspot_client/Screens/TurfDetailsScreen/Ui/Widget/AddressWidget.dart';
import 'package:playspot_client/Screens/TurfDetailsScreen/Ui/Widget/CarouselWidget.dart';
import 'package:playspot_client/Screens/TurfDetailsScreen/Ui/Widget/ReviewWidget.dart';
import 'package:playspot_client/Screens/TurfDetailsScreen/bloc/turf_details_bloc.dart';
import 'package:sizer/sizer.dart';

class TurfDetailsScreen extends StatefulWidget {
  final Map turfDetails;

  const TurfDetailsScreen({super.key, required this.turfDetails});

  @override
  State<TurfDetailsScreen> createState() => _TurfDetailsScreenState();
}

class _TurfDetailsScreenState extends State<TurfDetailsScreen> {
  TurfDetailsBloc turfDetailsBloc = TurfDetailsBloc();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: TextWidget(
            text: widget.turfDetails["name"].toString().toUpperCase(),
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: BlocConsumer<TurfDetailsBloc, TurfDetailsState>(
          bloc: turfDetailsBloc,
          listenWhen: (previous, current) => current is TurfDetailsActionState,
          buildWhen: (previous, current) => current is! TurfDetailsActionState,
          listener: (context, state) {
            if (state is NavigateToPricingScreenState) {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen:
                    PricingScreen(eventList: widget.turfDetails["eventList"]),
                withNavBar: false, // OPTIONAL VALUE. True by default.
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            }
            // TODO: implement listener
          },
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Column(
                    children: [
                      CarouselSliderWidget(
                        turfImages: widget.turfDetails["images"],
                        logo: widget.turfDetails["logo"],
                      ),
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundImage:
                              NetworkImage(widget.turfDetails["logo"]),
                        ),
                      ),
                      AddressWidget(
                        turfDeteils: widget.turfDetails,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                          width: 200,
                          child: ButtonWidget(
                            callback: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(),
                                screen: BookingScreen(
                                    ownerMail: widget.turfDetails["ownerMail"],
                                    turfName: widget.turfDetails["name"],
                                    address: widget.turfDetails["address"],
                                    location: widget.turfDetails["location"],
                                    turfLogo: widget.turfDetails["logo"],
                                    eventList: widget.turfDetails["eventList"],
                                    id: widget.turfDetails["_id"]),
                                withNavBar: false,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            text: "Book Now",
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: screenWidth,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                turfDetailsBloc
                                    .add(NavigateToPricingScreenEvent());
                              },
                              child: Container(
                                width: screenWidth * 0.4,
                                height: 45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1)),
                                child: Center(
                                    child: TextWidget(
                                  text: "Pricing",
                                  color: Colors.green,
                                  fontSize: 20,
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                PersistentNavBarNavigator
                                    .pushNewScreenWithRouteSettings(
                                  context,
                                  settings: RouteSettings(name: ""),
                                  screen: GoogleMapScreen(
                                      location: widget.turfDetails["location"]),
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                );
                              },
                              child: Container(
                                width: screenWidth * 0.45,
                                height: 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(width: 1)),
                                child: Center(
                                    child: TextWidget(
                                  text: "Location",
                                  color: Colors.green,
                                  fontSize: 20,
                                )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  widget.turfDetails["reviews"].length != 0
                      ? SizedBox(
                          width: screenWidth,
                          height: 500,
                          child: ReviewWidget(
                              reviewsInfo: widget.turfDetails["reviews"]))
                      : Container()
                ],
              ),
            );
          },
        ));
  }
}
