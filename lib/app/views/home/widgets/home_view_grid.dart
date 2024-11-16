import 'package:flutter/material.dart';
import 'package:muscle_zone/core/widgets/card/custom_card.dart';

/// A grid widget that displays a list of body parts
/// and handles their selection.
class HomeViewGrid extends StatelessWidget {
  /// Constructs a [HomeViewGrid] widget.
  const HomeViewGrid({
    required this.bodyParts,
    required this.onBodyPartSelected,
    super.key,
  });

  /// List of body parts to display in the grid.
  final List<String> bodyParts;

  /// Callback function to handle body part selection.
  final void Function(String) onBodyPartSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: bodyParts.length,
        itemBuilder: (context, index) {
          final bodyPart = bodyParts[index];

          return CustomCard(
            bodyPart: bodyPart,
            onTap: () => onBodyPartSelected(bodyPart),
          );
        },
      ),
    );
  }
}
