import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/BookingScreen/Widget/ClockTimeWidget.dart';
import 'package:playspot_client/Screens/BookingScreen/bloc/booking_bloc.dart';
import 'package:playspot_client/Screens/SpotsScreen/Model/SpotsTurfModel.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingScreen extends StatefulWidget {
  final List eventList;
  final String id;
  final turfName;
  final turfLogo;
  final Object location;
  final address;
  final ownerMail;
  BookingScreen(
      {super.key,
      required this.ownerMail,
      required this.address,
      required this.location,
      required this.turfLogo,
      required this.turfName,
      required this.eventList,
      required this.id});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  BookingBloc bookingBloc = BookingBloc();
  int currentIndex = 0;
  DateTime _date = DateTime.now();
  var totalPrice = "";

  String timeSlot = "";
  callbackForTimeSlot(varTimeSlot) {
    if (varTimeSlot.toString().isEmpty) {
      setState(() {
        totalPrice = "";
      });
    }

    setState(() {
      timeSlot = varTimeSlot;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    print(ModalRoute.of(context)?.settings.name);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: TextWidget(
          text: widget.turfName,
          color: Colors.white,
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: BlocConsumer<BookingBloc, BookingState>(
        bloc: bookingBloc,
        listenWhen: (previous, current) => current is BookingActionState,
        buildWhen: (previous, current) => current is BookingActionState,
        listener: (context, state) async {
          if (state is TotalPriceState) {
            setState(() {
              totalPrice = state.totalPrice;
            });
          }
          if (state is SubmitBookingInfoState) {
            print(state.url);
            if (!await launchUrl(Uri.parse(state.url))) {
              throw Exception('Could not launch ${state.url}');
            }
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return Stack(
            children: [
              Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(border: Border.all(width: 1)),
                          width: widget.eventList.length * 50,
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.eventList.length,
                            itemBuilder: (context, i) {
                              if (timeSlot.isNotEmpty) {
                                bookingBloc.add(TotalpriceEvent(
                                    timeSlot: timeSlot.toString().split("-"),
                                    price: DateFormat("EEEE").format(_date) ==
                                            "Friday"
                                        ? widget.eventList[i].weekendPrice
                                        : widget.eventList[i].weekdayPrice));
                              }

                              return Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: i == currentIndex
                                        ? Colors.green
                                        : Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          timeSlot = "";
                                          totalPrice = "";
                                          currentIndex = i;
                                        });
                                      },
                                      icon: Image.network(
                                        widget.eventList[i].icon,
                                        color: i == currentIndex
                                            ? Colors.white
                                            : null,
                                      )),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          _showDatePicker();
                        },
                        icon: Icon(
                          Icons.calendar_today,
                          size: 50,
                          color: Colors.grey,
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      text:
                          "Available booking on ${DateFormat.yMMMd().format(_date)} ${DateFormat("EEEE").format(_date)}",
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ClockTimeWidget(
                      date: DateFormat.yMMMd().format(_date),
                      turfId: widget.id,
                      eventName: widget.eventList[currentIndex].eventName,
                      dayPrice: DateFormat("EEEE").format(_date) == "Friday"
                          ? widget.eventList[currentIndex].weekendPrice
                          : widget.eventList[currentIndex].weekdayPrice,
                      index: currentIndex,
                      clockTimeList:
                          DateFormat("EEEE").format(_date) == "Friday"
                              ? widget.eventList[currentIndex].weekendTime
                              : widget.eventList[currentIndex].weekdayTime,
                      weekDay: DateFormat("EEEE").format(_date),
                      timeSlotCallback: callbackForTimeSlot,
                    ),
                  ],
                ),
              ),
              totalPrice.toString().isNotEmpty
                  ? Positioned(
                      bottom: 0,
                      child: Container(
                        width: screenWidth,
                        height: 50,
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: TextWidget(
                                text: totalPrice,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                                width: 100,
                                height: 50,
                                child: ButtonWidget(
                                    callback: () {
                                      submitBookingInfo();
                                    },
                                    text: "Book"))
                          ],
                        ),
                      ),
                    )
                  : Positioned(
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(width: 1)),
                        width: screenWidth,
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 100,
                              height: 50,
                              child: Center(
                                  child: TextWidget(
                                text: "Next",
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              )),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey.shade400),
                            )
                          ],
                        ),
                      ),
                    )
            ],
          );
        },
      ),
    );
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2025))
        .then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  void submitBookingInfo() {
    var name = FirebaseAuth.instance.currentUser?.displayName;
    var email = FirebaseAuth.instance.currentUser?.email;
    print(email);
    var bookingInfo = {
      "turfName": widget.turfName,
      "turfLogo": widget.turfLogo,
      "location": widget.location,
      "address": widget.address,
      'email': email,
      "ownerMail": widget.ownerMail,
      "customerName": name,
      "turfId": widget.id,
      "date": DateFormat.yMMMd().format(_date),
      "slot": timeSlot,
      "eventName": widget.eventList[currentIndex].eventName,
      "totalPrice": totalPrice
    };
    bookingBloc.add(SubmitBookingInfoEvent(bookingInfo: bookingInfo));
  }

  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
