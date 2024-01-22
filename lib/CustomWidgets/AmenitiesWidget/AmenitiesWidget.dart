import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:sizer/sizer.dart';

class AmenitiesWidget extends StatefulWidget {
  final List anemitiestList;
  const AmenitiesWidget({super.key, required this.anemitiestList});

  @override
  State<AmenitiesWidget> createState() => _AmenitiesWidgetState();
}

class _AmenitiesWidgetState extends State<AmenitiesWidget> {
  TextEditingController anemitiesNameController = TextEditingController();
  TextEditingController anemitiesiconController = TextEditingController();
  var iconName;
  var iconPath;
  bool isClicked = false;
  bool isreadOnly = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextFieldWidget(
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Anemities name is required";
                }
                return null;
              },
              readOnly: isreadOnly,
              controllerName: anemitiesNameController,
              width: 45.w,
              hintText: "Anemities name",
            ),
            TextFieldWidget(
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Anemities icon is required";
                }
                return null;
              },
              icon: Icon(Icons.browse_gallery),
              controllerName: TextEditingController(text: iconName),
              width: 45.w,
              hintText: "Select icon for anemities",
              callback: isreadOnly == true
                  ? () {}
                  : () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles();

                      if (result != null) {
                        PlatformFile file = result.files.first;

                        iconName = file.name;
                        iconPath = file.path;
                        setState(() {});
                      } else {
                        // User canceled the picker
                      }
                    },
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: "Click add icon for add this anemities"),
            SizedBox(
              width: 5,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      widget.anemitiestList.add({
                        "anemitiesName":
                            anemitiesNameController.text.toString(),
                        "icon": iconPath
                      });
                      setState(() {
                        isClicked = true;
                        isreadOnly = true;
                      });
                    },
                    icon: isClicked == true
                        ? Icon(Icons.check)
                        : Icon(Icons.add_box))),
          ],
        )
      ],
    );
  }
}
