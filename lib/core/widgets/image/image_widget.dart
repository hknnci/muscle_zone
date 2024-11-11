import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final String imagePath;
  final double width;
  final double height;

  const ImageWidget({
    Key? key,
    required this.imagePath,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
