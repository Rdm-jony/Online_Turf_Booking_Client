import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:playspot_client/Screens/BottomNavbar/Ui/BottomNavbar.dart';
import 'package:playspot_client/Screens/Home/Ui/HomeScreen.dart';
import 'package:playspot_client/Screens/ProfileInfoScreen/Repo/ProfileInfoRepo.dart';
import 'package:playspot_client/Screens/ProfileInfoScreen/bloc/profile_info_bloc.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/ProfilePhotoWidgets/ProfilePhotoWidget.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/VerifyScreen/Repo/VerifyRepo.dart';
import 'package:sizer/sizer.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  ProfileInfoBloc profileInfoBloc = ProfileInfoBloc();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String? selectedGender = "Male";
  final user = FirebaseAuth.instance.currentUser;

  var dob;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: BlocConsumer<ProfileInfoBloc, ProfileInfoState>(
          bloc: profileInfoBloc,
          listenWhen: (previous, current) => current is ProfileInfoActionState,
          buildWhen: (previous, current) => current is! ProfileInfoActionState,
          listener: (context, state) {
            if (state is ProfileInfoSuccessState) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BottomNavbar(),
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
                child: Column(
                  children: [
                    ProfilePhotoWidget(
                      callback: () {
                        filePickerFunction();
                      },
                      image: user!.photoURL.toString(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        filePickerFunction();
                      },
                      child: TextWidget(
                        text: "Change profile image",
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: formKey,
                        child: Expanded(
                          child: Column(
                            children: [
                              TextFieldWidget(
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Username is required";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.text,
                                hintText: "Username",
                                controllerName: nameController =
                                    TextEditingController(
                                        text: user?.displayName),
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Phone number is required";
                                  } else if (!RegExp(
                                          r'^(?:(?:\+|00)88|01)?\d{11}\r?$')
                                      .hasMatch(value)) {
                                    return "Invalid phone number";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.phone,
                                hintText: "Enter your phone number",
                                controllerName: phoneController =
                                    TextEditingController(
                                        text: user?.phoneNumber),
                                icon: Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextFieldWidget(
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "email is required";
                                  } else if (!RegExp(
                                          (r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'))
                                      .hasMatch(value)) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
                                hintText: "Enter your email",
                                readOnly: user?.email != null ? true : false,
                                controllerName: mailController =
                                    TextEditingController(text: user?.email),
                                icon: Icon(
                                  Icons.mail,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFieldWidget(
                                callback: () {
                                  datePickerFunction();
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty) {
                                    return "Date of birth is required";
                                  }
                                  return null;
                                },
                                readOnly: true,
                                controllerName: dobController =
                                    TextEditingController(text: dob),
                                hintText: "Enter your birthday",
                                icon: Icon(
                                  Icons.date_range,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Icon(Icons.person),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedGender = "Male";
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: selectedGender == "Male"
                                                ? Colors.grey.shade600
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(width: 0.5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextWidget(
                                            text: "Male",
                                            color: selectedGender == "Male"
                                                ? Colors.white
                                                : null,
                                          ),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedGender = "Female";
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: selectedGender == "Female"
                                                ? Colors.grey.shade600
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(width: 0.5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextWidget(
                                              text: "Female",
                                              color: selectedGender == "Female"
                                                  ? Colors.white
                                                  : null),
                                        )),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedGender = "Other";
                                      });
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                            color: selectedGender == "Other"
                                                ? Colors.grey.shade600
                                                : null,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(width: 0.5)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: TextWidget(
                                            text: "Other",
                                            color: selectedGender == "Other"
                                                ? Colors.white
                                                : null,
                                          ),
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: ButtonWidget(
                                  callback: () {
                                    submitUserInfoFunction();
                                  },
                                  text: "Continue",
                                  width: 100,
                                  height: 30,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      )),
    );
  }

  void filePickerFunction() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      bool isTrue = await ProfileInfoRepo.updateUserInfoFunction(file.path);

      if (isTrue) {
        setState(() {});
      }
    }
  }

  void datePickerFunction() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1950),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2100));

    if (pickedDate != null) {
      String formattedDate = DateFormat('d MMM y').format(pickedDate);
      //formatted date output using intl package =>  2021-03-16
      setState(() {
        dob = formattedDate;
      });
    } else {}
  }

  void submitUserInfoFunction() async {
    var userPhoto = FirebaseAuth.instance.currentUser?.photoURL;
    var isValid = formKey.currentState?.validate();

    if (isValid == true) {
      if (user?.email == null) {
        var user = FirebaseAuth.instance.currentUser;

        await user?.updateEmail(mailController.text);
        print(user);
      }

      var userInfo = {
        "userName": nameController.text.toString(),
        "phoneNumber": phoneController.text.toString(),
        "email": mailController.text.toString(),
        "dob": dobController.text.toString(),
        "gender": selectedGender,
        "image": userPhoto,
      };
      profileInfoBloc.add(SendUserInfoToDbEvent(userInfo: userInfo));
    }
  }
}
