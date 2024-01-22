import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playspot_client/Screens/MybookingScreen/Widget/MyBookingWiget.dart';
import 'package:playspot_client/Screens/TurfOwner/ViewBookedTurf/bloc/booked_turf_bloc.dart';

class BookedTurf extends StatefulWidget {
  BookedTurf({super.key});

  @override
  State<BookedTurf> createState() => _BookedTurfState();
}

class _BookedTurfState extends State<BookedTurf> {
  BookedTurfBloc bookedTurfBloc = BookedTurfBloc();
  @override
  void initState() {
    bookedTurfBloc.add(FatchBookedTurfEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<BookedTurfBloc, BookedTurfState>(
        bloc: bookedTurfBloc,
        listenWhen: (previous, current) => current is BookedTurfActionState,
        buildWhen: (previous, current) => current is! BookedTurfActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchBookedTurfLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );

            case FatchBookedTurfSuccessState:
              final success = state as FatchBookedTurfSuccessState;
              return MyBookingWidget(
                allBookings: success.allBooked,
              );
          }
          return Container();
        },
      ),
    );
  }
}
