import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/core/widgets/texts/custom_text.dart';

class CustomCard extends StatelessWidget {
  final String bodyPart;
  final Function() onTap;

  const CustomCard({
    Key? key,
    required this.bodyPart,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fitness_center, size: 40),
            const SizedBox(height: 10),
            CustomText.titleMedium(bodyPart.capitalizeFirst!),
          ],
        ),
      ),
    );
  }
}
