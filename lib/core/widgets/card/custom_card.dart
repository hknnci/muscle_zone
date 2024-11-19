import 'package:flutter/material.dart';
import 'package:muscle_zone/core/extensions/string_extensions.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

/// A custom card widget for displaying exercise information.
/// [bodyPart] displays the name of the body part.
/// [onTap] specifies the function to be called when the card is tapped.
class CustomCard extends StatelessWidget {
  /// Constructs a [CustomCard] widget.
  const CustomCard({
    required this.bodyPart,
    required this.onTap,
    this.child,
    super.key,
  });

  /// The name of the body part to be displayed.
  final String bodyPart;

  /// Callback function to be executed when the card is tapped.
  final VoidCallback onTap;

  /// Optional child widget to be displayed inside the card.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: child ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.fitness_center, size: 40),
                  const SizedBox(height: 20),
                  CustomText.bodyMedium(bodyPart.toTitleCase()),
                ],
              ),
        ),
      ),
    );
  }
}
