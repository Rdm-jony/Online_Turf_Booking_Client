import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:playspot_client/Screens/Home/Repo/HomeRepo.dart';
import 'package:playspot_client/Screens/Home/Widget/LocationVariable.dart';

class DistanceWidget extends StatefulWidget {
  final latitude;
  final longiTude;
  DistanceWidget({super.key, required this.latitude, required this.longiTude});

  @override
  State<DistanceWidget> createState() => _DistanceWidgetState();
}

class _DistanceWidgetState extends State<DistanceWidget> {
  var distance;
  @override
  void initState() {
    getDistance();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return distance.toString().isEmpty ? Text("") : Text("(${distance} km)");
  }

  void getDistance() async {
    var userLatitude = CurrentLocationCoordinate.latitude;
    var userLongitude = CurrentLocationCoordinate.longitude;
    
    double distanceInMeters = Geolocator.distanceBetween(
      double.parse(userLatitude.toString()),
      double.parse(userLongitude.toString()),
      double.parse(widget.latitude.toString()),
      double.parse(widget.longiTude.toString()),
    );
    double ditanceInKM = distanceInMeters / 1000;
    setState(() {
      distance = ditanceInKM.toStringAsFixed(2);
    });
  }
}
