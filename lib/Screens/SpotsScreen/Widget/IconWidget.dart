import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IconWidget extends StatelessWidget {
  final eventListIcon;
  IconWidget({super.key, required this.eventListIcon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 30,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: eventListIcon.length,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox.square(
              dimension: 20,
              child: Image.network(eventListIcon[i].icon),
            ),
          );
        },
      ),
    );
  }
}
