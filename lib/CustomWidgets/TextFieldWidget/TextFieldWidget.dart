import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:sizer/sizer.dart';

class TextFieldWidget extends StatelessWidget {
  final Icon? icon;
  final TextEditingController? controllerName;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? callback;
  final FormFieldValidator? validator;
  final width;

  const TextFieldWidget(
      {super.key,
      this.icon,
      this.controllerName,
      this.hintText,
      this.keyboardType,
      this.readOnly = false,
      this.width = double.maxFinite,
      this.validator,
      this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width,
      child: TextFormField(
        validator: validator,
        cursorColor: Colors.black,
        onTap: callback,
        readOnly: readOnly,
        keyboardType: keyboardType,
        textAlignVertical: TextAlignVertical.center,
        controller: controllerName,
        decoration: InputDecoration(
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          hintText: hintText,
          prefixIcon: icon,
        ),
      ),
    );
  }
}
