import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/Screens/TurfDetailsScreen/Ui/Widget/PhotoViewWidget.dart';

class CarouselSliderWidget extends StatefulWidget {
  final List turfImages;
  final String logo;
  CarouselSliderWidget(
      {super.key, required this.turfImages, required this.logo});

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
              enableInfiniteScroll: true,
              height: screenHeight * 0.5,
              viewportFraction: 1,
              aspectRatio: 2.0,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
              autoPlay: true),
          items: widget.turfImages.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    child: SizedBox(
                        width: screenWidth,
                        child: InkWell(
                          onTap: () {
                            PersistentNavBarNavigator
                                .pushNewScreenWithRouteSettings(
                              context,
                              settings: RouteSettings(),
                              screen: PhotoViewWidget(
                                galleryItems: widget.turfImages,
                                initialIndex: widget.turfImages.indexOf(i),
                              ),
                              withNavBar: false,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: Image.network(
                            i,
                            fit: BoxFit.fill,
                          ),
                        )));
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          left: screenWidth * 0.50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.turfImages.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.black
                              : Colors.white)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        ),
       
      ],
    );
  }
}
