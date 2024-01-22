import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/BookingScreen/Widget/BootomSheetWidget.dart';
import 'package:playspot_client/Screens/BookingScreen/bloc/booking_bloc.dart';

class ClockTimeWidget extends StatefulWidget {
  final List clockTimeList;
  final weekDay;
  final timeSlotCallback;
  final int index;
  final eventName;
  final turfId;
  final date;
  final dayPrice;

  ClockTimeWidget(
      {super.key,
      required this.dayPrice,
      required this.date,
      required this.turfId,
      required this.clockTimeList,
      required this.weekDay,
      required this.timeSlotCallback,
      required this.index,
      required this.eventName});

  @override
  State<ClockTimeWidget> createState() => _ClockTimeWidgetState();
}

class _ClockTimeWidgetState extends State<ClockTimeWidget> {
  BookingBloc bookingBloc = BookingBloc();
  List startClocktime = [];
  List endClocTime = [];
  TextEditingController fromTimeController = TextEditingController();
  TextEditingController toTimeController = TextEditingController();
  int currentIndex = 0;

  // ignore: non_constant_identifier_names
  callback(Map varTimeController) {
    if (varTimeController["fromTime"] == true) {
      setState(() {
        fromTimeController.text = varTimeController["time"];
      });
    } else {
      setState(() {
        toTimeController.text = varTimeController["time"];
        widget.timeSlotCallback(
            "${fromTimeController.text}-${toTimeController.text}");
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    bookingBloc.add(StartTimeListEvent(clockTime: widget.clockTimeList));

    bookingBloc.add(EndTimeListEvent(
        clockTime: widget.clockTimeList,
        fromTime: fromTimeController.text.toString()));
    if (currentIndex != widget.index) {
      fromTimeController.text = "";
      toTimeController.text = "";
      currentIndex = widget.index;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<BookingBloc, BookingState>(
      bloc: bookingBloc,
      listenWhen: (previous, current) => current is BookingActionState,
      buildWhen: (previous, current) => current is! BookingActionState,
      listener: (context, state) {
        if (state is StartTimeListState) {
          startClocktime = state.startTimeList;
        } else if (state is EndTimeListState) {
          endClocTime = state.endTimeList;
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        print(widget.clockTimeList);
        return SizedBox(
          width: screenWidth,
          height: 500,
          child: Column(
            children: [
              Container(
                width: screenWidth,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.green),
                child: Center(
                    child: TextWidget(
                  text: "${widget.weekDay}",
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontSize: 18,
                )),
              ),
              SizedBox(
                width: screenWidth,
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.clockTimeList.length,
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          width: screenWidth * 0.6,
                          height: 50,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Center(
                              child: TextWidget(
                            text: widget.clockTimeList[index],
                            fontWeight: FontWeight.w500,
                          )),
                        ),
                        Container(
                          width: screenWidth * 0.4,
                          height: 50,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade300),
                          child: Center(
                              child: TextWidget(
                            text: 'bdt/= ${widget.dayPrice}',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.green,
                          )),
                        )
                      ],
                    );
                  },
                ),
              ),
              SizedBox(
                width: screenWidth,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: screenWidth * 0.3,
                      height: 80,
                      child: Column(
                        children: [
                          TextWidget(
                            text: "From",
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                          TextFormField(
                            controller: fromTimeController,
                            readOnly: true,
                            onTap: () {
                              bottomModal({
                                "fromTime": true,
                                "clockTime": startClocktime
                              });
                              setState(() {
                                toTimeController.text = "";
                                widget.timeSlotCallback("");
                              });
                            },
                            decoration: InputDecoration(
                              hintText: "HH:MM",
                            ),
                          ),
                        ],
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.black,
                      width: 50,
                    ),
                    SizedBox(
                        width: screenWidth * 0.3,
                        height: 80,
                        child: Column(
                          children: [
                            TextWidget(
                              text: "To",
                              color: Colors.green,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            ),
                            TextFormField(
                              readOnly: true,
                              controller: toTimeController,
                              onTap: () {
                                if (fromTimeController.text
                                    .toString()
                                    .isNotEmpty) {
                                  bottomModal({
                                    "toTime": true,
                                    "clockTime": endClocTime
                                  });
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              "Please choose fromtime!!")));
                                }
                              },
                              decoration: InputDecoration(
                                hintText: "HH:MM",
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void bottomModal(Map clocktime) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return BottaomSheetWidget(
          weeeday: widget.weekDay,
          date: widget.date,
          turfId: widget.turfId,
          eventName: widget.eventName,
          clockTimeList: clocktime,
          callbackFunction: callback,
        );
      },
    );
  }
}
