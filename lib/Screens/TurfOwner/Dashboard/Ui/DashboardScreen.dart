import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playspot_client/CustomWidgets/AmenitiesWidget/AmenitiesWidget.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/PricingWidgets/PricingWidgets.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:playspot_client/Screens/TurfOwner/Dashboard/Repo/DashboardRepo.dart';
import 'package:playspot_client/Screens/TurfOwner/Dashboard/bloc/dashboard_bloc.dart';
import 'package:sizer/sizer.dart';

class DashboardScreen extends StatefulWidget {
  DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  DashboardBloc dashboardBloc = DashboardBloc();
  var _formKey = GlobalKey<FormState>();
  TextEditingController imagesController = TextEditingController();
  TextEditingController logoController = TextEditingController();
  TextEditingController turfNameController = TextEditingController();
  TextEditingController latitudeController = TextEditingController();
  TextEditingController logitudeController = TextEditingController();
  TextEditingController numberOfEvent = TextEditingController(text: "1");
  TextEditingController numberOfAnemities = TextEditingController(text: "1");
  TextEditingController addressController = TextEditingController();
  var eventList = [];
  var anemitiestList = [];
  var allImagesName = "";
  var logoName;
  var logoImagePath;
  var imagesFile;
  final List<String> division = [
    'Chittagong',
    'Dhaka',
    'Barisal',
    'Khulna',
    'Mymensingh',
    'Rajshahi',
    'Rangpur',
    'Sylhet'
  ];

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: 100.w,
        height: 100.h,
        child: Form(
          key: _formKey,
          child: BlocConsumer<DashboardBloc, DashboardState>(
            bloc: dashboardBloc,
            listenWhen: (previous, current) => current is DashboardActionState,
            buildWhen: (previous, current) => current is! DashboardActionState,
            listener: (context, state) {
              if (state is TurfInfoAddToDbSuccessState) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sucessfully added turf!")));
              }
              // TODO: implement listener
            },
            builder: (context, state) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    TextFieldWidget(
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Plz select one or more images";
                        }

                        return null;
                      },
                      controllerName: imagesController =
                          TextEditingController(text: allImagesName),
                      callback: () async {
                        imagesFile = await uploadImage();

                        for (var i = 0; i < imagesFile.length; i++) {
                          var image = imagesFile[i].toString().split("/").last;
                          allImagesName = allImagesName +
                              " / " +
                              image.substring(0, image.length - 1);
                        }

                        setState(() {});
                      },
                      icon: Icon(Icons.browse_gallery),
                      hintText: "Select multiple images",
                      readOnly: true,
                    ),
                    TextFieldWidget(
                      icon: Icon(Icons.browse_gallery),
                      readOnly: true,
                      hintText: "Select a logo",
                      controllerName: logoController =
                          TextEditingController(text: logoName),
                      callback: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();

                        if (result != null) {
                          PlatformFile file = result.files.first;

                          logoName = file.name;
                          logoImagePath = file.path;
                          setState(() {});
                        } else {
                          // User canceled the picker
                        }
                      },
                    ),
                    TextFieldWidget(
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "Truf name is required!";
                        }
                        return null;
                      },
                      hintText: "Turf name",
                      controllerName: turfNameController,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            width: 45.w,
                            child: TextFieldWidget(
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Latitude is requred!";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              hintText: "Latitude: ",
                              controllerName: latitudeController,
                            )),
                        SizedBox(
                          width: 10.w,
                        ),
                        SizedBox(
                            width: 45.w,
                            child: TextFieldWidget(
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Longitude is required!";
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              hintText: "Longitude: ",
                              controllerName: logitudeController,
                            ))
                      ],
                    ),
                    DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        // Add Horizontal padding using menuItemStyleData.padding so it matches
                        // the menu padding when button's width is not specified.
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        // Add more decoration..
                      ),
                      hint: const Text(
                        'Select Your Division',
                        style: TextStyle(fontSize: 14),
                      ),
                      items: division
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select division';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        //Do something when selected item is changed.
                        selectedValue = value.toString();
                        setState(() {});
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                        setState(() {});
                      },
                      buttonStyleData: const ButtonStyleData(
                        padding: EdgeInsets.only(right: 8),
                      ),
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black45,
                        ),
                        iconSize: 24,
                      ),
                      dropdownStyleData: DropdownStyleData(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      menuItemStyleData: const MenuItemStyleData(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                      ),
                    ),
                    TextFieldWidget(
                      controllerName: addressController,
                      hintText: "Nearby address",
                      validator: (value) {
                        if (value.toString().isEmpty) {
                          return "address is required!";
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Select number of event :"),
                        SizedBox(
                          width: 5.w,
                        ),
                        TextFieldWidget(
                          controllerName: numberOfEvent,
                          keyboardType: TextInputType.number,
                          width: 10.w,
                        ),
                        ButtonWidget(
                          width: 30.w,
                          text: "Generate",
                          callback: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 5.h,
                        ),
                        SizedBox(
                          width: 40.w,
                          child: Divider(
                            thickness: 2,
                            color: Colors.green,
                          ),
                        ),
                        Text("Add event"),
                        SizedBox(
                          width: 40.w,
                          child: Divider(
                            thickness: 2,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 500,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: int.parse(numberOfEvent.text),
                        itemBuilder: (context, index) {
                          return PricingListWidgets(eventList: eventList);
                        },
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("Select number of anemities :"),
                        SizedBox(
                          width: 5.w,
                        ),
                        TextFieldWidget(
                          controllerName: numberOfAnemities,
                          keyboardType: TextInputType.number,
                          width: 10.w,
                        ),
                        ButtonWidget(
                          width: 30.w,
                          text: "Generate",
                          callback: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: 4.h,
                        ),
                        SizedBox(
                          width: 35.w,
                          child: Divider(
                            thickness: 2,
                            color: Colors.green,
                          ),
                        ),
                        TextWidget(text: "Add anemities"),
                        SizedBox(
                          width: 35.w,
                          child: Divider(
                            thickness: 2,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 300,
                      child: ListView.builder(
                        itemCount: int.parse(numberOfAnemities.text.toString()),
                        itemBuilder: (context, index) {
                          return AmenitiesWidget(
                              anemitiestList: anemitiestList);
                        },
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _formKey.currentState?.reset();
                        },
                        child: Text("Reset")),
                    ButtonWidget(
                        callback: () {
                          submitTurfInfo();
                        },
                        text: "Add Turf"),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<List> uploadImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'webp', 'png'],
    );

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();
      // List turfUploadImages = await DashboardRepo.uploadTurfImage(files);
      // return turfUploadImages;
      return files;
    } else {
      // User canceled the picker
      return [];
    }
  }

  void submitTurfInfo() async {
    var isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      var turfImages = await DashboardRepo.uploadTurfImage(imagesFile);
      var turfLogo = await DashboardRepo.uploadTurfLogo(logoImagePath);
      for (var i = 0; i < eventList.length; i++) {
        var imageUrl = await DashboardRepo.uploadTurfLogo(eventList[i]["icon"]);

        eventList[i]["icon"] = imageUrl;
      }

      for (var i = 0; i < anemitiestList.length; i++) {
        var imageUrl =
            await DashboardRepo.uploadTurfLogo(anemitiestList[i]["icon"]);

        anemitiestList[i]["icon"] = imageUrl;
      }

      Map turfInfo = {
        "images": turfImages,
        "logo": turfLogo,
        "name": turfNameController.text.toString(),
        "location": {
          "latitude": double.parse(latitudeController.text),
          "longitude": double.parse(logitudeController.text),
        },
        "division": selectedValue.toString(),
        "address": addressController.text.toString(),
        "eventList": eventList,
        "anemities": anemitiestList,
        "reviews": []
      };

      dashboardBloc.add(TurfInfoAddToDbEvent(turfInfo: turfInfo));
    }
  }
}
