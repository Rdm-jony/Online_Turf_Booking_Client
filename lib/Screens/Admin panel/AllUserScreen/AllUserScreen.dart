import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/Admin%20panel/AllUserScreen/bloc/all_user_bloc.dart';
import 'package:playspot_client/Screens/BottomNavbar/Repo/NavbarRepo.dart';

class AllUserScreen extends StatefulWidget {
  AllUserScreen({super.key});

  @override
  State<AllUserScreen> createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  AllUserBloc allUserBloc = AllUserBloc();
  var userRole;
  @override
  void initState() {
    userRoleFuction();

    allUserBloc.add(FatchAllUserEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocConsumer<AllUserBloc, AllUserState>(
        bloc: allUserBloc,
        listenWhen: (previous, current) => current is AllUserActionState,
        buildWhen: (previous, current) => current is! AllUserActionState,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case FatchAllUserLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case FatchAllUserSuccessState:
              final success = state as FatchAllUserSuccessState;
              return ListView.builder(
                itemCount: success.allUser.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: screeWidth,
                      height: 150,
                      child: Card(
                        elevation: 5,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                success.allUser[index].image != null
                                    ? CircleAvatar(
                                        radius: 30,
                                        backgroundImage: NetworkImage(
                                            success.allUser[index].image))
                                    : Icon(
                                        Icons.person,
                                        size: 30,
                                      ),
                                TextWidget(
                                  text: success.allUser[index].userName,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextWidget(
                                      text: success.allUser[index].email,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    TextWidget(
                                      text: success.allUser[index].phoneNumber,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                                width: screeWidth,
                                child: Divider(
                                  thickness: 2,
                                )),
                            SizedBox(
                              width: screeWidth,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    SizedBox(
                                      width: screeWidth * 0.4,
                                      child:
                                          success.allUser[index].role == "admin"
                                              ? ButtonWidget(
                                                  callback: () {
                                                    allUserBloc.add(
                                                        SetUserRoleEvent(
                                                            userRole: "user",
                                                            email: success
                                                                .allUser[index]
                                                                .email));
                                                  },
                                                  text: "Undo")
                                              : ButtonWidget(
                                                  callback: () {
                                                    allUserBloc.add(
                                                        SetUserRoleEvent(
                                                            userRole: "admin",
                                                            email: success
                                                                .allUser[index]
                                                                .email));
                                                  },
                                                  text: "Set Admin"),
                                    ),
                                    SizedBox(
                                      width: screeWidth * 0.4,
                                      child: success.allUser[index].role ==
                                              "turfOwner"
                                          ? ButtonWidget(
                                              callback: () {
                                                allUserBloc.add(
                                                    SetUserRoleEvent(
                                                        userRole: "user",
                                                        email: success
                                                            .allUser[index]
                                                            .email));
                                              },
                                              text: "Undo")
                                          : ButtonWidget(
                                              callback: () {
                                                allUserBloc.add(
                                                    SetUserRoleEvent(
                                                        userRole: "turfOwner",
                                                        email: success
                                                            .allUser[index]
                                                            .email));
                                              },
                                              text: "Set Turf Owner"),
                                    )
                                  ]),
                            )
                          ],
                        ),
                      ));
                      
                },
              );
          }
          return Container();
        },
      ),
    );
  }

  void userRoleFuction() async {
    userRole = await NavbarRepo.fatchUserRole();
    setState(() {});
  }
}
