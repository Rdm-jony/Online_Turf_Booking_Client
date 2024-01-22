import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:go_router/go_router.dart';
import 'package:playspot_client/Screens/BottomNavbar/Ui/BottomNavbar.dart';
import 'package:playspot_client/Screens/ExploreScreen/Ui/ExploreScreen.dart';
import 'package:playspot_client/Screens/RegisterScreen/Ui/RegisterScreen.dart';
import 'package:playspot_client/Screens/VerifyScreen/Ui/VerifyScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    whereToGo();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SizedBox(
              width: 200, child: Image.asset("assets/images/logo.jpeg")),
        ),
      ),
    );
  }

  void whereToGo() {
    Timer(Duration(seconds: 3), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var isLogedIn = prefs.getBool("KEYLOGIN");

      if (isLogedIn != null) {
        if (isLogedIn) {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BottomNavbar(),
          ));
        } else {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => RegisterScreen(),
          ));
        }
      } else {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ExploreScreen(),
        ));
      }
    });
  }
}
