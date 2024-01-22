import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/Home/bloc/home_bloc.dart';
import 'package:playspot_client/Screens/SpotsScreen/Ui/SpotsScreen.dart';

class DivisionWidget extends StatefulWidget {
  const DivisionWidget({super.key});

  @override
  State<DivisionWidget> createState() => _DivisionWidgetState();
}

class _DivisionWidgetState extends State<DivisionWidget> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(FatchCategoryDivisionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case FacthDivisionSuccessState:
            final success = state as FacthDivisionSuccessState;
            return ListView.builder(
              itemCount: success.division.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: screenWidth,
                  height: 200,
                  child: Stack(
                    children: [
                      Container(
                        width: screenWidth,
                        height: 200,
                        child: Card(
                          child: Image.asset(
                            "assets/images/turfCategory.png",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: screenWidth,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: Center(
                            child: TextWidget(
                              text: success.division[index]
                                  .toString()
                                  .toUpperCase(),
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: 0,
                          right: 5,
                          child: InkWell(
                            onTap: () {
                              PersistentNavBarNavigator
                                  .pushNewScreenWithRouteSettings(
                                context,
                                settings: RouteSettings(name: ""),
                                screen: SpotsScreen(
                                    division: success.division[index]),
                                withNavBar: true,
                                pageTransitionAnimation:
                                    PageTransitionAnimation.cupertino,
                              );
                            },
                            child: Icon(
                              Icons.arrow_right_alt,
                              color: Colors.white,
                              size: 50,
                            ),
                          ))
                    ],
                  ),
                );
              },
            );
        }
        return Container();
      },
    );
  }
}
