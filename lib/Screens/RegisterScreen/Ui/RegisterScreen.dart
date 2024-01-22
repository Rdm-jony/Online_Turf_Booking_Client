import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playspot_client/Screens/ProfileInfoScreen/Ui/ProfileInfoScreen.dart';
import 'package:playspot_client/Screens/RegisterScreen/bloc/register_bloc.dart';
import 'package:playspot_client/Screens/VerifyScreen/Ui/VerifyScreen.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:sizer/sizer.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterBloc registerBloc = RegisterBloc();
  bool buttonActive = false;
  TextEditingController phoneNumberController = TextEditingController();
  var phoneNumber = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        bloc: registerBloc,
        listenWhen: (previous, current) => current is RegisterActionState,
        buildWhen: (previous, current) => current is! RegisterActionState,
        listener: (context, state) {
          if (state is SendOtpSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => VerifyScreen(phoneNubmer: phoneNumber),
                ));
          } else if (state is LogInSuccessState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileInfoScreen(),
                ));
          }
          // TODO: implement listener
        },
        builder: (context, state) {
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 180,
                        height: 80,
                        child: Image.asset("assets/images/logo.jpeg"),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextWidget(
                      text: "Join the playspots community",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                        child: Column(
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 50,
                          child: TextFormField(
                            controller: phoneNumberController,
                            maxLength: 10,
                            onChanged: (value) {
                              if (value.length == 10) {
                                setState(() {
                                  phoneNumber = phoneNumberController.text;
                                  buttonActive = true;
                                });
                              } else {
                                setState(() {
                                  buttonActive = false;
                                });
                              }
                            },
                            keyboardType: TextInputType.number,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1),
                            cursorColor: Colors.green,
                            decoration: InputDecoration(
                                counterText: "",
                                prefixIcon: SizedBox(
                                  width: 75,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      CountryFlag.fromCountryCode(
                                        "bd",
                                        width: 30,
                                        height: 30,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      TextWidget(
                                        text: "+880 ",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ],
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.green))),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ButtonWidget(
                          text: "Sign up with phone number",
                          opacity: buttonActive ? 1 : 0.6,
                          callback: () {
                            if (buttonActive) {
                              registerBloc
                                  .add(SendOtpEvent(phoneNumber: phoneNumber));
                            }
                          },
                        )
                      ],
                    )),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        registerBloc.add(SigninWithGoogleEvent());
                      },
                      child: Container(
                        width: 100.w,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1)),
                        child: Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          child: Row(
                            children: [
                              Image.asset("assets/images/google.png"),
                              SizedBox(
                                width: 20,
                              ),
                              TextWidget(
                                text: "Continue with google",
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ));
        },
      ),
    );
  }
}
