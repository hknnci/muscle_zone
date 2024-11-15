import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/exercise_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

class ExercisesController extends GetxController {
  final ExerciseService _exerciseService;

  ExercisesController(this._exerciseService);

  var exercises = <BaseObjectModel>[].obs;
  var filteredExercises = <BaseObjectModel>[].obs;
  var equipmentList = <String>[].obs;
  var currentPageIndex = 0.obs;
  var selectedEquipment = ''.obs;
  var isLoading = false.obs;
  var isLoadingMore = false.obs;
  var isFetchingMore = false.obs;
  final PageController pageController = PageController();

  // Pagination limit and offset
  final int limit = 10;
  var offset = 0;

  @override
  void onInit() {
    super.onInit();
    fetchExercises();
    fetchEquipmentList();

    // Adding a scroll listener to the page controller
    pageController.addListener(_handleScroll);
  }

  // Scroll listener
  void _handleScroll() {
    if (pageController.position.atEdge &&
        pageController.position.pixels != 0 &&
        !isLoadingMore.value) {
      loadMoreExercises();
    }
  }

  // Fetch exercises based on BodyPart and equipment filter
  Future<void> fetchExercises({bool isLoadMore = false}) async {
    try {
      if (isLoadMore) {
        isLoadingMore(true);
        isFetchingMore(true);
        offset += limit;
      } else {
        isLoading(true);
        offset = 0;
      }

      var newExercises = await _exerciseService.getExercisesByBodyPart(
        Get.arguments,
        limit: limit,
        offset: offset,
      );

      // Filter by selected equipment
      final selectedEquipmentLowerCase = selectedEquipment.value.toLowerCase();
      if (selectedEquipmentLowerCase != 'all' &&
          selectedEquipmentLowerCase.isNotEmpty) {
        newExercises = _filterByEquipment(newExercises);
      }

      if (newExercises.isEmpty && isLoadMore) {
        // Show Flushbar if no more exercises are available
        CustomFlushbar.showInfo(AppKeys.endOfTheList);
      }

      // Add new exercises to the list
      if (isLoadMore) {
        exercises.addAll(newExercises);
        filteredExercises.addAll(newExercises);
      } else {
        exercises.assignAll(newExercises);
        filteredExercises.assignAll(newExercises);
      }
    } catch (e) {
      print("Error fetching exercises: $e");
    } finally {
      if (isLoadMore) {
        isLoadingMore(false);
        isFetchingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  // Load more exercises
  void loadMoreExercises() async {
    await fetchExercises(isLoadMore: true);
  }

  // Fetch equipment list
  Future<void> fetchEquipmentList() async {
    try {
      isLoading(true);
      equipmentList.value = await _exerciseService.getEquipmentList();
      equipmentList.insert(0, "All");
    } catch (e) {
      print("Error fetching equipment list: $e");
    } finally {
      isLoading(false);
    }
  }

  // Filter exercises based on selected equipment
  void filterExercisesByEquipment(String equipment) {
    isLoading(true);

    selectedEquipment.value = equipment;

    if (equipment.toLowerCase() == 'all') {
      filteredExercises.assignAll(exercises);
    } else {
      filteredExercises.assignAll(_filterByEquipment(exercises));
    }

    // Reset page index and jump to the first page in PageView
    _resetPageIndex();

    isLoading(false);
  }

  // Function to apply equipment filter
  List<BaseObjectModel> _filterByEquipment(
    List<BaseObjectModel> exercisesList,
  ) {
    final equipmentLowerCase = selectedEquipment.value.toLowerCase();
    return exercisesList
        .where((exercise) =>
            exercise.equipment.toLowerCase() == equipmentLowerCase)
        .toList();
  }

  // Reset page index
  void _resetPageIndex() {
    currentPageIndex.value = 0;
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  // Update page index
  void updatePageIndex(int index) {
    currentPageIndex.value = index;
  }
}
