import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final double? width;
  final double? height;
  final Color? color;
  final VoidCallback? callback;
  final double opacity;

  const ButtonWidget(
      {super.key,
      required this.text,
      this.width = double.maxFinite,
      this.color,
      this.callback,
      this.height = 40,
      this.opacity = 1.0});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callback,
      child: Opacity(
        opacity: opacity,
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                boxShadow: [BoxShadow(blurRadius: 1)],
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromARGB(255, 20, 91, 22),
                      Colors.green,
                    ])),
            child: Center(
                child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ))),
      ),
    );
  }
}
