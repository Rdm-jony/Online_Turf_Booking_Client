import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapScreen extends StatefulWidget {
  final location;

  const GoogleMapScreen({super.key, required this.location});
  @override
  State<GoogleMapScreen> createState() => GoogleMapScreenState();
}

class GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    final CameraPosition _kGoogle = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 17.4746,
    );
    
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGoogle,
        mapType: MapType.normal,
        myLocationEnabled: true,
        compassEnabled: true,
        markers: {
          Marker(
              markerId: MarkerId("chittagong"),
              position:
                  LatLng(widget.location.latitude, widget.location.longitude))
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
