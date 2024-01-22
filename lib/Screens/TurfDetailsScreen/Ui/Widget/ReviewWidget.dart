import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';

class ReviewWidget extends StatelessWidget {
  final reviewsInfo;
  const ReviewWidget({super.key, required this.reviewsInfo});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: reviewsInfo.length,
      itemBuilder: (context, index) {
        return SizedBox(
          width: screenWidth,
          child: Card(
            child: Column(children: [
              SizedBox(
                  width: screenWidth,
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Center(
                          child: TextWidget(
                            text: reviewsInfo[index]
                                .name
                                .toString()
                                .substring(0, 1),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        height: 50,
                        child: Column(
                          children: [
                            TextWidget(
                              text: reviewsInfo[index].name,
                              fontWeight: FontWeight.bold,
                            ),
                            RatingBarIndicator(
                              rating: 2.75,
                              itemBuilder: (context, index) => Icon(
                                Icons.star,
                                color: Colors.green,
                              ),
                              itemCount: 5,
                              itemSize: 15,
                              direction: Axis.horizontal,
                            ),
                          ],
                        ),
                      ),
                      TextWidget(
                        text: reviewsInfo[index].date,
                        color: Colors.green,
                      )
                    ],
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextWidget(
                    overFlow: TextOverflow.ellipsis,
                    maxLine: 5,
                    text: reviewsInfo[index].feedback),
              )
            ]),
          ),
        );
      },
    );
  }
}
