import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/Screens/RegisterScreen/Ui/RegisterScreen.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(autoPlay: true),
            items: [
              "assets/images/slideImage1.jpg",
              "assets/images/slideImage2.jpg",
              "assets/images/slideImage3.jpg",
            ].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                      width: 200,
                      height: 200,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      child: SizedBox(
                        child: Image.asset(
                          i,
                          fit: BoxFit.contain,
                        ),
                      ));
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 50,
          ),
          TextWidget(
            text: "The largest network of sports facilities",
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextWidget(
                textAlign: TextAlign.center,
                text:
                    "Join playSpots to explore the largest network of sports facilities and to connect with the sports community all over bangladesh"),
          ),
          SizedBox(
            height: 10,
          ),
          ButtonWidget(
            text: "Explore",
            width: 100,
            callback: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterScreen(),
                  ));
            },
          )
        ],
      )),
    );
  }
}
