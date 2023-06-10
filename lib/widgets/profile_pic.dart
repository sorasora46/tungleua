import 'dart:convert';

import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({Key? key, this.image}) : super(key: key);
  final String? image;

  @override
  Widget build(BuildContext context) {
    return image == null
        ? const CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(Icons.person, color: Colors.white, size: 100),
          )
        : CircleAvatar(
            backgroundImage: MemoryImage(base64Decode(image!)),
          );
  }
}
