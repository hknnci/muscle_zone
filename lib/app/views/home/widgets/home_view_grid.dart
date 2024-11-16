import 'package:flutter/material.dart';
import 'package:muscle_zone/core/widgets/card/custom_card.dart';

class HomeViewGrid extends StatelessWidget {
  final List<String> bodyParts;
  final Function(String) onBodyPartSelected;

  const HomeViewGrid({
    Key? key,
    required this.bodyParts,
    required this.onBodyPartSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1,
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
