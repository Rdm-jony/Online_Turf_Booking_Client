import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final maxLine;
  final overFlow;

  TextWidget(
      {super.key,
      required this.text,
      this.color = Colors.black54,
      this.fontSize = 14,
      this.fontWeight = FontWeight.w400,
      this.textAlign = TextAlign.left,
      this.overFlow = null,
      this.maxLine = null});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        maxLines: maxLine,
        textAlign: textAlign,
        overflow: overFlow,
        style: GoogleFonts.roboto(
            color: color, fontSize: fontSize, fontWeight: fontWeight));
  }
}
