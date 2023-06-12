import 'dart:typed_data';

import 'package:flutter/material.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage(
      {Key? key,
      required this.image,
      required this.index,
      required this.removeImage})
      : super(key: key);
  final Uint8List image;
  final int index;
  final void Function(int)? removeImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox.fromSize(
            size: const Size.fromRadius(38),
            child: Image.memory(image, fit: BoxFit.cover),
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: ElevatedButton(
            onPressed: () => removeImage != null ? removeImage!(index) : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: removeImage != null
                  ? Colors.red
                  : Colors.grey, // Set background color to red
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(
                  4), // Adjust the padding to make the button smaller
              minimumSize:
                  const Size(24, 24), // Set a minimum size for the button
            ),
            child: const Icon(
              Icons.close,
              color: Colors.white,
              size: 16, // Adjust the size of the icon to fit the smaller button
            ),
          ),
        ),
      ],
    );
  }
}
