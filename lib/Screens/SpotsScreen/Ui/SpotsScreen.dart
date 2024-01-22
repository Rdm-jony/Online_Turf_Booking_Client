import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/Screens/SpotsScreen/Model/SpotsTurfModel.dart';
import 'package:playspot_client/Screens/SpotsScreen/Widget/DistanceWidget.dart';
import 'package:playspot_client/Screens/SpotsScreen/Widget/IconWidget.dart';
import 'package:playspot_client/Screens/SpotsScreen/bloc/spots_bloc.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/TurfDetailsScreen/Ui/TurfDetailsScreen.dart';
import 'package:sizer/sizer.dart';

class SpotsScreen extends StatefulWidget {
  final division;
  const SpotsScreen({super.key, this.division});

  @override
  State<SpotsScreen> createState() => _SpotsScreenState();
}

class _SpotsScreenState extends State<SpotsScreen> {
  SpotsBloc spotsBloc = SpotsBloc();
  var locationAddress;
  @override
  void initState() {
    spotsBloc.add(FatchSpotsEvent(division: widget.division));

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        leadingWidth: 400,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 10,
            ),
            TextWidget(
              text: "All Turfs",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: 20,
            ),
            SizedBox(
                width: 200,
                height: 40,
                child: TextFormField(
                  controller: TextEditingController(
                      text: widget.division != null ? widget.division : null),
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(Icons.search), hintText: "Search"),
                  onChanged: (value) {
                    spotsBloc.add(FilerBySearchTexttEvent(searchText: value));
                  },
                )),
            IconButton(
                onPressed: () {
                  bottomModal();
                },
                icon: Icon(
                  Icons.event_available,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
      body: BlocConsumer<SpotsBloc, SpotsState>(
        bloc: spotsBloc,
        listenWhen: (previous, current) => current is SpotsActionState,
        buildWhen: (previous, current) => current is! SpotsActionState,
        listener: (context, state) {
          if (state is NavigateToTurfDetailsState) {
            PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              context,
              settings: RouteSettings(),
              screen: TurfDetailsScreen(turfDetails: state.turfDetails),
              withNavBar: false,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case AllSpotsLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case AllSpotsSuccessState:
              final success = state as AllSpotsSuccessState;
              return ListView.builder(
                itemCount: success.allSpots.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.05),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [BoxShadow(blurRadius: 1)],
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100),
                            bottomLeft: Radius.circular(100))),
                    width: screenWidth,
                    height: 110,
                    child: InkWell(
                      onTap: () async {
                        var locationAddress = await getLocation(
                          success.allSpots[index].location.latitude,
                          success.allSpots[index].location.longitude,
                        );
                        spotsBloc.add(NavigateToTurfDetailsEvent(turfDetails: {
                          "_id": success.allSpots[index].sId,
                          "images": success.allSpots[index].images,
                          "logo": success.allSpots[index].logo,
                          "name": success.allSpots[index].name,
                          "location": success.allSpots[index].location,
                          "eventList": success.allSpots[index].eventList,
                          "anemities": success.allSpots[index].anemities,
                          "reviews": success.allSpots[index]?.reviews,
                          "address":
                              "${locationAddress},${success.allSpots[index].address}",
                          "ownerMail": success.allSpots[index].ownerMail
                        }));
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            width: screenWidth * 0.3,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 7,
                                ),
                                CircleAvatar(
                                  radius: 45,
                                  backgroundColor: Colors.grey,
                                  backgroundImage: NetworkImage(
                                      success.allSpots[index].logo),
                                ),
                                SizedBox(
                                  width: 10,
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: screenWidth * 0.6,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  text: success.allSpots[index].name,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: screenHeight * 0.10,
                                      child: TextWidget(
                                          overFlow: TextOverflow.ellipsis,
                                          maxLine: 1,
                                          text:
                                              success.allSpots[index].address),
                                    ),
                                    DistanceWidget(
                                      latitude: success
                                          .allSpots[index].location.latitude,
                                      longiTude: success
                                          .allSpots[index].location.longitude,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: screenWidth * 0.6,
                                  child: Divider(
                                    color: Color.fromARGB(255, 53, 51, 51),
                                    thickness: 1,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconWidget(
                                        eventListIcon:
                                            success.allSpots[index].eventList),
                                    ButtonWidget(
                                      text: "Book",
                                      width: 70,
                                    )
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
          }
          return Container();
        },
      ),
    );
  }

  Future<String> getLocation(latitude, longitude) async {
    var placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );
    return "${placemarks[0].toJson()["locality"]},${placemarks[0].toJson()["subLocality"]}";
  }

  void bottomModal() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          width: 100.w,
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              TextWidget(
                text: "Search by sports Icon :",
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.green)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            spotsBloc.add(
                                FilterByEventNameEvent(eventName: "Football"));
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.sports_football_sharp)),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(width: 2, color: Colors.green)),
                    child: Center(
                      child: IconButton(
                          onPressed: () {
                            spotsBloc.add(
                                FilterByEventNameEvent(eventName: "Cricket"));
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.sports_cricket)),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
