import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/MyBookingDetailsScreen/Ui/MyBookingDetailsScreen.dart';
import 'package:playspot_client/Screens/MybookingScreen/Widget/MyBookingWiget.dart';
import 'package:playspot_client/Screens/MybookingScreen/bloc/mybooking_bloc.dart';

class MybookingScreen extends StatefulWidget {
  const MybookingScreen({super.key});

  @override
  State<MybookingScreen> createState() => _MybookingScreenState();
}

class _MybookingScreenState extends State<MybookingScreen> {
  MybookingBloc mybookingBloc = MybookingBloc();
  @override
  void initState() {
    mybookingBloc.add(FatchMyBookingEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextWidget(
          text: "My Booking".toUpperCase(),
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: BlocConsumer<MybookingBloc, MybookingState>(
        bloc: mybookingBloc,
        listenWhen: (previous, current) => current is MybookingActionState,
        buildWhen: (previous, current) => current is! MybookingActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchMyBookingsLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case FatchMyBookingsSuccessState:
              final success = state as FatchMyBookingsSuccessState;

              return MyBookingWidget(
                allBookings: success.allBookings,
              );
          }
          return Container();
        },
      ),
    );
  }
}
