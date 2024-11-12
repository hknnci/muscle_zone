import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Database"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Select a Body Part",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Show muscle groups
          Obx(() {
            if (controller.bodyParts.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.bodyParts.length,
                itemBuilder: (context, index) {
                  final bodyPart = controller.bodyParts[index];
                  return GestureDetector(
                    onTap: () => controller.fetchExercisesByBodyPart(bodyPart),
                    child: Card(
                      margin: const EdgeInsets.all(8.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            bodyPart,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }),
          const Divider(),
          // Show exercises
          Obx(() {
            if (controller.exercises.isEmpty) {
              return const Expanded(
                child: Center(
                  child: Text("No exercises found for the selected body part."),
                ),
              );
            }

            return Expanded(
              child: ListView.builder(
                itemCount: controller.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = controller.exercises[index];
                  return ListTile(
                    leading: exercise.gifUrl.isNotEmpty
                        ? Image.network(
                            exercise.gifUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported),
                    title: Text(exercise.name),
                    subtitle: Text(exercise.target),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
