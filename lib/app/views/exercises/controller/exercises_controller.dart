import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

/// Controller class that manages exercise-related operations and states
class ExercisesController extends GetxController {
  /// Constructor for ExercisesController
  /// _exerciseService is the service responsible for exercise-related API call
  ExercisesController(this._exerciseService);

  final ExerciseService _exerciseService;

  /// List of all exercises
  final RxList<BaseObjectModel> exercises = <BaseObjectModel>[].obs;

  /// List of filtered exercises based on selected equipment
  final RxList<BaseObjectModel> filteredExercises = <BaseObjectModel>[].obs;

  /// List of available equipment types
  final RxList<String> equipmentList = <String>[].obs;

  /// Current page index in the PageView
  final RxInt currentPageIndex = 0.obs;

  /// Currently selected equipment filter
  final RxString selectedEquipment = ''.obs;

  /// Loading state indicator
  final RxBool isLoading = false.obs;

  /// Indicates if more exercises are currently being loaded
  final RxBool isLoadingMore = false.obs;

  /// Tracks the fetching state for additional exercises
  RxBool isFetchingMore = false.obs;

  /// Controls the page scrolling and navigation
  final PageController pageController = PageController();

  /// Maximum number of items to fetch per request
  final int limit = 10;

  /// Current offset for pagination
  int offset = 0;

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

  /// Fetch exercises based on BodyPart and equipment filter
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
        Get.arguments as String,
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
      print('Error fetching exercises: $e');
    } finally {
      if (isLoadMore) {
        isLoadingMore(false);
        isFetchingMore(false);
      } else {
        isLoading(false);
      }
    }
  }

  /// Loads additional exercises when scrolling reaches the end of the list
  Future<void> loadMoreExercises() async {
    await fetchExercises(isLoadMore: true);
  }

  /// Fetches the list of available equipment from the exercise service
  Future<void> fetchEquipmentList() async {
    try {
      isLoading(true);
      equipmentList
        ..value = await _exerciseService.getEquipmentList()
        ..insert(0, 'All');
    } catch (e) {
      print('Error fetching equipment list: $e');
    } finally {
      isLoading(false);
    }
  }

  /// Filters the exercise list based on the selected equipment type
  /// [equipment] is the equipment type to filter by
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
        .where(
          (exercise) => exercise.equipment.toLowerCase() == equipmentLowerCase,
        )
        .toList();
  }

  // Reset page index
  void _resetPageIndex() {
    currentPageIndex.value = 0;
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  /// Updates the current page index in the PageView
  /// [index] is the new page index to set
  // ignore: use_setters_to_change_properties
  void updatePageIndex(int index) {
    currentPageIndex.value = index;
  }
}
