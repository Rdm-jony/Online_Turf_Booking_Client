import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/Screens/Home/Widget/Banner.dart';
import 'package:playspot_client/Screens/Home/Widget/DiviisionWidget.dart';
import 'package:playspot_client/Screens/Home/Widget/Location.dart';
import 'package:playspot_client/Screens/Home/bloc/home_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100.w,
        leading: CurrentLocation(),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 300, child: HomeBanner()),
            SizedBox(width: screen, height: 400, child: DivisionWidget())
          ],
        ),
      ),
    );
  }
}
