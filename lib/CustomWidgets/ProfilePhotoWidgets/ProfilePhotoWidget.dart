import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ProfilePhotoWidget extends StatelessWidget {
  final image;
  final VoidCallback? callback;
  const ProfilePhotoWidget({super.key, this.image, this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 5, color: Colors.green)),
      child: InkWell(
          onTap: callback,
          child: image == null
              ? CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/profileAvatar.jpg"),
                )
              : CircleAvatar(
                  backgroundColor: Colors.grey.shade400,
                  backgroundImage: NetworkImage(image.toString()),
                )),
    );
  }
}
