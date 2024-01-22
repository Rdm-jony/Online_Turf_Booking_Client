import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/PricingScreen/Widget/PriceListWidget.dart';

class PricingScreen extends StatefulWidget {
  final List eventList;
  PricingScreen({super.key, required this.eventList});

  @override
  State<PricingScreen> createState() => _PricingScreenState();
}

class _PricingScreenState extends State<PricingScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    print(widget.eventList);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextWidget(
          text: "Price List",
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: widget.eventList.length * 115,
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.eventList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            currentIndex = index;
                          });
                        },
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                  width: currentIndex == index ? 2 : 1,
                                  color: Colors.green)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox.square(
                                dimension: currentIndex == index ? 50 : 40,
                                child: Image.network(
                                  widget.eventList[index].icon,
                                  color: Colors.green,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              TextWidget(
                                text: widget.eventList[index].groundSize,
                                color: Colors.green,
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          PriceListWidget(
            event: widget.eventList[currentIndex],
          )
        ],
      ),
    );
  }
}
