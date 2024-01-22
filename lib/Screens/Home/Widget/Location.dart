import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/Home/Repo/HomeRepo.dart';
import 'package:playspot_client/Screens/Home/Widget/LocationVariable.dart';
import 'package:playspot_client/Screens/Home/Widget/PlaceSearchWidget.dart';
import 'package:playspot_client/Screens/Home/bloc/home_bloc.dart';

class CurrentLocation extends StatefulWidget {
  const CurrentLocation({super.key});

  @override
  State<CurrentLocation> createState() => _CurrentLocationState();
}

class _CurrentLocationState extends State<CurrentLocation> {
  HomeBloc homeBloc = HomeBloc();

  var locality = "";
  var sublocality = "";
  var placemarks;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  String searchAddress = "";
  callbackForSerchLocation(varAddress) {
    setState(() {
      searchAddress = varAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    getLocaiton();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 300,
        leading: SizedBox(
          child: Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
              sublocality != ""
                  ? InkWell(
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: ""),
                          screen: PlaceSearchWidget(
                              callbackForSerchLocation:
                                  callbackForSerchLocation,
                              deviceLocation: "${locality},${sublocality}"),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: TextWidget(
                        text: searchAddress.isNotEmpty
                            ? searchAddress
                            : "${locality},${sublocality}",
                      ),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        SizedBox.square(
                            dimension: 15,
                            child: CircularProgressIndicator(
                              strokeWidth: 1,
                            )),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void getLocaiton() async {
    if (searchAddress.isEmpty) {
      var selectedLocation = await HomeRepo.determinePosition();
      placemarks = await placemarkFromCoordinates(
          selectedLocation.latitude, selectedLocation.longitude);
      CurrentLocationCoordinate.latitude = selectedLocation.latitude;
      CurrentLocationCoordinate.longitude = selectedLocation.longitude;
    } else {
      List<Location> locations = await locationFromAddress(searchAddress);
      CurrentLocationCoordinate.latitude = locations[0].latitude;
      CurrentLocationCoordinate.longitude = locations[0].longitude;
    }

    setState(() {
      locality = placemarks[0].toJson()["locality"];
      sublocality = placemarks[0].toJson()["subLocality"];
    });
  }
}
