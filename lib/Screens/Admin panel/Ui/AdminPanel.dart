import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:playspot_client/Screens/Admin%20panel/AllUserScreen/AllUserScreen.dart';

class AdminDashboard extends StatefulWidget {
  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  List screen = [AllUserScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Admin'),
        ),
        sideBar: SideBar(
          items: const [
            AdminMenuItem(
              title: 'All User',
              route: '/',
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
