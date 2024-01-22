import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:playspot_client/Screens/TurfOwner/Dashboard/Ui/DashboardScreen.dart';
import 'package:playspot_client/Screens/TurfOwner/ViewBookedTurf/Ui/BookedTurf.dart';

class TurfOwnerDashboard extends StatefulWidget {
  @override
  State<TurfOwnerDashboard> createState() => _TurfOwnerDashboardState();
}

class _TurfOwnerDashboardState extends State<TurfOwnerDashboard> {
  List screen = [DashboardScreen(), BookedTurf()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Turf Owner'),
        ),
        sideBar: SideBar(
          items: const [
            AdminMenuItem(
              title: 'Add Turf',
              route: '/',
              icon: Icons.dashboard,
            ),
            AdminMenuItem(
              title: 'Booked Turf',
              route: '/bookedTurf',
              icon: Icons.dashboard,
            ),
          ],
          selectedRoute: '/',
          onSelected: (item) {
            if (item.route == "/") {
              setState(() {
                index = 0;
              });
            }
            if (item.route == "/bookedTurf") {
              setState(() {
                index = 1;
              });
            }
          },
          header: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'header',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 50,
            width: double.infinity,
            color: const Color(0xff444444),
            child: const Center(
              child: Text(
                'footer',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: screen[index]);
  }
}
