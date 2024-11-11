import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/views/home/controller/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  //todo: TBC..

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exercise Database"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Obx(
              () => DropdownButton<String>(
                value: controller.selectedBodyPart,
                onChanged: controller.filterByBodyPart,
                items: const [
                  DropdownMenuItem(value: "all", child: Text("All")),
                  DropdownMenuItem(value: "back", child: Text("Back")),
                  DropdownMenuItem(value: "chest", child: Text("Chest")),
                ],
              ),
            ),
          ),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.exercises.length,
                itemBuilder: (context, index) {
                  final exercise = controller.exercises[index];
                  return ListTile(
                    leading: Image.network(exercise.gifUrl),
                    title: Text(exercise.name),
                    subtitle: Text(exercise.bodyPart),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
