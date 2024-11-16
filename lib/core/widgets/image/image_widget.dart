import 'package:flutter/material.dart';

/// A widget that displays an asset image with specified dimensions.
class ImageWidget extends StatelessWidget {
  /// Constructs an [ImageWidget] widget.
  const ImageWidget({
    required this.imagePath,
    required this.width,
    required this.height,
    super.key,
  });

  /// The path of the image to be displayed
  final String imagePath;

  /// The width of the image
  final double width;

  /// The height of the image
  final double height;

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
