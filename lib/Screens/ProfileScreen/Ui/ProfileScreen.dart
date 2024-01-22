import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/ProfilePhotoWidgets/ProfilePhotoWidget.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/ProfileScreen/bloc/profile_bloc.dart';
import 'package:playspot_client/Screens/RegisterScreen/Ui/RegisterScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileBloc profileBloc = ProfileBloc();
  @override
  void initState() {
    profileBloc.add(FatchProfileInfoEvent());
    // TODO: implement initState
    super.initState();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 100.w,
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: "Profile",
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: ButtonWidget(
                  text: "Log Out",
                  callback: () {
                    logOut();
                  },
                ),
              )
            ],
          ),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          bloc: profileBloc,
          listenWhen: (previous, current) => current is ProfileActionState,
          buildWhen: (previous, current) => current is! ProfileActionState,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case FatchProfileInfoLoadingState:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case FatchProfileInfoSuccessState:
                final success = state as FatchProfileInfoSuccessState;
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        ProfilePhotoWidget(
                          callback: () {},
                          image: success.profileInfo["image"],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: () async {
                                filePickerFunction();
                              },
                              child: Icon(
                                Icons.camera_enhance_sharp,
                                color: Colors.grey,
                              ),
                            ))
                      ],
                    ),
                    Form(
                        child: Expanded(
                      child: Column(
                        children: [
                          TextFieldWidget(
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            controllerName: nameController =
                                TextEditingController(
                                    text: success.profileInfo["userName"]),
                            icon: Icon(
                              Icons.person,
                              color: Colors.black,
                            ),
                          ),
                          TextFieldWidget(
                            readOnly: true,
                            keyboardType: TextInputType.phone,
                            controllerName: phoneController =
                                TextEditingController(
                                    text: success.profileInfo["phoneNumber"]),
                            icon: Icon(
                              Icons.phone,
                              color: Colors.black,
                            ),
                          ),
                          TextFieldWidget(
                            readOnly: true,
                            controllerName: mailController =
                                TextEditingController(
                                    text: success.profileInfo["email"]),
                            icon: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                          ),
                          TextFieldWidget(
                            readOnly: true,
                            controllerName: dobController =
                                TextEditingController(
                                    text: success.profileInfo['dob']),
                            icon: Icon(
                              Icons.date_range,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.person),
                              Container(
                                  decoration: BoxDecoration(
                                      color: success.profileInfo["gender"] ==
                                              "Male"
                                          ? Colors.grey
                                          : null,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextWidget(
                                      text: "Male",
                                      color: success.profileInfo["gender"] ==
                                              "Male"
                                          ? Colors.white
                                          : null,
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      color: success.profileInfo["gender"] ==
                                              "Female"
                                          ? Colors.grey
                                          : null,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextWidget(
                                      text: "Female",
                                      color: success.profileInfo["gender"] ==
                                              "Female"
                                          ? Colors.white
                                          : null,
                                    ),
                                  )),
                              Container(
                                  decoration: BoxDecoration(
                                      color: success.profileInfo["gender"] ==
                                              "Other"
                                          ? Colors.grey
                                          : null,
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(width: 0.5)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: TextWidget(
                                      text: "Other",
                                      color: success.profileInfo["gender"] ==
                                              "Other"
                                          ? Colors.white
                                          : null,
                                    ),
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ))
                  ],
                );
            }
            return Container();
          },
        ));
  }

  void filePickerFunction() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      profileBloc.add(UploadProfilePhotoEvent(imagePath: file.path));
    }
  }

  void logOut() async {
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('KEYLOGIN');

    PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
      context,
      settings: RouteSettings(name: ""),
      screen: RegisterScreen(),
      withNavBar: true,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );
  }
}
