import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/BookingScreen/bloc/booking_bloc.dart';

class BottaomSheetWidget extends StatefulWidget {
  final Map clockTimeList;
  final eventName;
  final turfId;
  final date;
  final weeeday;

  final Function callbackFunction;
  const BottaomSheetWidget(
      {super.key,
      required this.weeeday,
      required this.date,
      required this.turfId,
      required this.eventName,
      required this.clockTimeList,
      required this.callbackFunction});

  @override
  State<BottaomSheetWidget> createState() => _BottaomSheetWidgetState();
}

class _BottaomSheetWidgetState extends State<BottaomSheetWidget> {
  BookingBloc bookingBloc = BookingBloc();
  @override
  void initState() {
    bookingBloc.add(AvailableTimeSlotEvent(
        weekday: widget.weeeday,
        date: widget.date,
        eventName: widget.eventName,
        turfId: widget.turfId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ScreenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<BookingBloc, BookingState>(
      bloc: bookingBloc,
      listenWhen: (previous, current) => current is BookingActionState,
      buildWhen: (previous, current) => current is! BookingActionState,
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case AvailableTimeLoadingState:
            return Center(
              child: CircularProgressIndicator(),
            );
          case AvailableTimeSuccessState:
            final success = state as AvailableTimeSuccessState;
            return SizedBox(
              width: ScreenWidth,
              height: 300,
              child: GridView.builder(
                scrollDirection: Axis.vertical,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: widget.clockTimeList["clockTime"].length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (!success.availableTime.contains(
                          widget.clockTimeList["clockTime"][index])) {
                        return MotionToast.error(
                                title: Text("Error"),
                                description:
                                    Text("This time is already Booked"))
                            .show(context);
                      }
                      if (widget.clockTimeList["fromTime"] == true) {
                        widget.callbackFunction({
                          "fromTime": true,
                          "time": widget.clockTimeList["clockTime"][index]
                        });
                        Navigator.pop(context);
                      } else {
                        widget.callbackFunction({
                          "toTime": true,
                          "time": widget.clockTimeList["clockTime"][index]
                        });
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: TextWidget(
                          fontWeight: FontWeight.w600,
                          text: widget.clockTimeList["clockTime"][index],
                        ),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.grey, blurRadius: 2)
                          ],
                          border: Border.all(width: 1),
                          color: success.availableTime.contains(
                                  widget.clockTimeList["clockTime"][index])
                              ? Colors.grey.shade300
                              : Colors.red),
                    ),
                  );
                },
              ),
            );
        }
        return Container();
      },
    );
  }
}
