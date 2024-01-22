import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:playspot_client/Screens/ProfileInfoScreen/Ui/ProfileInfoScreen.dart';
import 'package:playspot_client/Screens/VerifyScreen/bloc/verify_bloc.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:sizer/sizer.dart';

class VerifyScreen extends StatefulWidget {
  final phoneNubmer;
  VerifyScreen({required this.phoneNubmer});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  TextEditingController smsController = TextEditingController();
  bool buttonActive = false;
  VerifyBloc verifyBloc = VerifyBloc();
  var start = 120;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: BlocConsumer<VerifyBloc, VerifyState>(
        bloc: verifyBloc,
        listenWhen: (previous, current) => current is VerifyActionState,
        buildWhen: (previous, current) => current is! VerifyActionState,
        listener: (context, state) {
          if (state is VerifySuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileInfoScreen(),
                ));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: SizedBox(
              width: 100.w,
              height: 100.h,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      textAlign: TextAlign.center,
                      text: "Enter OTP",
                      fontSize: 30,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextWidget(
                      text: "Enter the verification code send to",
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                    TextWidget(
                      text: "+880 ${widget.phoneNubmer}",
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      child: Pinput(
                        controller: smsController,
                        length: 6,
                        onChanged: (value) {
                          if (value.length == 6) {
                            setState(() {
                              buttonActive = true;
                            });
                          } else {
                            setState(() {
                              buttonActive = false;
                            });
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ButtonWidget(
                      text: "Verify",
                      opacity: buttonActive ? 1 : 0.6,
                      callback: () {
                        if (buttonActive) {
                          verifyBloc.add(VerifyNumberEvent(
                              smsCode: smsController.text.toString()));
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextWidget(
                          text: "Change Number",
                          fontSize: 16,
                          color: Colors.green[700],
                          fontWeight: FontWeight.w600,
                        ),
                        start > 0
                            ? TextWidget(
                                text: "Resend in ${start}",
                                color: Colors.green[400],
                                fontWeight: FontWeight.w600,
                              )
                            : InkWell(
                                onTap: () {
                                  start = 120;
                                  startTimer();

                                  verifyBloc.add(ResendCodeEvent(
                                      phoneNumber: widget.phoneNubmer));
                                },
                                child: TextWidget(
                                  text: "Resend Code",
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w600,
                                ))
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )),
    );
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (start > 0) {
        setState(() {
          start--;
        });
      } else {
        timer.cancel();
      }
    });
  }
}
