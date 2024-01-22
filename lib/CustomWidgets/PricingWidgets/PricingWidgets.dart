import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:playspot_client/CustomWidgets/ButtonWidget/ButtonWidget.dart';
import 'package:playspot_client/CustomWidgets/TextFieldWidget/TextFieldWidget.dart';
import 'package:playspot_client/CustomWidgets/TextWidget/TextWidget.dart';
import 'package:sizer/sizer.dart';

class PricingListWidgets extends StatefulWidget {
  final List eventList;

  PricingListWidgets({super.key, required this.eventList});

  @override
  State<PricingListWidgets> createState() => _PricingListWidgetsState();
}

class _PricingListWidgetsState extends State<PricingListWidgets> {
  var iconName;

  var iconPath;
  bool isClicked = false;
  bool isreadOnly = false;

  TextEditingController eventNameController = TextEditingController();
  TextEditingController iconNameController = TextEditingController();
  TextEditingController weekendTimeController = TextEditingController();
  TextEditingController weekendPriceController = TextEditingController();
  TextEditingController weekdayTimeController = TextEditingController();
  TextEditingController weekdayPriceController = TextEditingController();
  TextEditingController holidayTimeController = TextEditingController();
  TextEditingController holidayPriceController = TextEditingController();
  TextEditingController groundSizeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            TextFieldWidget(
              readOnly: isreadOnly,
              controllerName: eventNameController,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Event name is required!";
                }
                return null;
              },
              width: 50.w,
              hintText: "Event name",
            ),
            TextFieldWidget(
              readOnly: isreadOnly,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Event icon is required!";
                }
                return null;
              },
              width: 50.w,
              icon: Icon(Icons.browse_gallery),
              hintText: "Select event icon",
              controllerName: iconNameController =
                  TextEditingController(text: iconName),
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
        TextFieldWidget(
          hintText: "Ground Size(ex: 5x5/full ground,)",
          controllerName: groundSizeController,
          validator: (value) {
            if (value.toString().isEmpty) {
              return "Ground size is required";
            }
            return null;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldWidget(
              readOnly: isreadOnly,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "weekday time is required!";
                }
                return null;
              },
              width: 70.w,
              hintText: "Weekday(ex: 07.00-08.30 am, 13.00-17.00 pm)",
              controllerName: weekdayTimeController,
              keyboardType: TextInputType.text,
            ),
            TextFieldWidget(
              readOnly: isreadOnly,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "weekday price is required!";
                }
                return null;
              },
              width: 25.w,
              hintText: "Price(per hour)",
              keyboardType: TextInputType.number,
              controllerName: weekdayPriceController,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextFieldWidget(
              readOnly: isreadOnly,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "weekend time is required!";
                }
                return null;
              },
              width: 70.w,
              hintText: "Weekend(ex: 07.00-08.30 am, 13.00-17.00 pm)",
              controllerName: weekendTimeController,
              keyboardType: TextInputType.text,
            ),
            TextFieldWidget(
              readOnly: isreadOnly,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "weekend price is required!";
                }
                return null;
              },
              width: 25.w,
              hintText: "Price",
              keyboardType: TextInputType.number,
              controllerName: weekendPriceController,
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextWidget(text: "Click add icon for add this event"),
            SizedBox(
              width: 5,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                    onPressed: () {
                      widget.eventList.add({
                        "eventName": eventNameController.text.toString(),
                        "icon": iconPath,
                        "groundSize": groundSizeController.text.toString(),
                        "weekdayTime":
                            weekdayTimeController.text.toString().split(","),
                        "weekdayPrice": weekdayPriceController.text.toString(),
                        "weekendTime":
                            weekendTimeController.text.toString().split(","),
                        "weekendPrice": weekendPriceController.text.toString(),
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
