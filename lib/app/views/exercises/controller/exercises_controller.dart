import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

/// Controller class that manages exercise-related operations and states
class ExercisesController extends GetxController {
  /// Constructor for ExercisesController
  /// _exerciseService is the service responsible for exercise-related API calls
  ExercisesController(this._exerciseService, {required this.bodyPart});

  final ExerciseService _exerciseService;

  /// The body part for which exercises are being fetched
  final String bodyPart;

  /// List of all exercises
  final RxList<BaseObjectModel> exercises = <BaseObjectModel>[].obs;

  /// List of filtered exercises based on selected equipment
  final RxList<BaseObjectModel> filteredExercises = <BaseObjectModel>[].obs;

  /// List of available equipment types
  final RxList<String> equipmentList = <String>[].obs;

  /// List of available target muscle groups
  final RxList<String> targetList = <String>[].obs;

  /// Current page index in the PageView
  final RxInt currentPageIndex = 0.obs;

  /// Currently selected equipment filter
  final RxString selectedEquipment = ''.obs;

  /// Currently selected target filter
  final RxString selectedTarget = ''.obs;

  /// Loading state indicator
  final RxBool isLoading = false.obs;

  /// Indicates if more exercises are currently being loaded
  final RxBool isLoadingMore = false.obs;

  /// Controller for the PageView
  final PageController pageController = PageController();

  /// Pagination constants
  static const int _pageLimit = 10;

  /// Current offset for pagination
  int _offset = 0;

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  /// Initialize controller data
  Future<void> _initializeData() async {
    await Future.wait([
      fetchExercises(),
      fetchEquipmentList(),
      fetchTargetList(),
    ]);
    pageController.addListener(_handleScroll);
  }

  /// Handle scroll events for pagination
  void _handleScroll() {
    final isAtEnd =
        pageController.position.atEdge && pageController.position.pixels != 0;
    if (isAtEnd && !isLoadingMore.value) {
      loadMoreExercises();
    }
  }

  /// Fetch exercises with pagination support
  Future<void> fetchExercises({bool isLoadMore = false}) async {
    try {
      _setLoadingState(isLoadMore);

      final newExercises = await _exerciseService.getExercisesByBodyPart(
        bodyPart,
        offset: _offset,
      );

      if (newExercises.isEmpty) {
        _handleEmptyResponse(isLoadMore);
        return;
      }

      _updateExerciseLists(newExercises);
    } catch (e) {
      // Handle error silently
    } finally {
      _resetLoadingState(isLoadMore);
    }
  }

  /// Filter exercises by equipment type
  Future<void> filterExercisesByEquipment(String equipment) async {
    try {
      isLoading(true);
      selectedEquipment.value = equipment;
      _offset = 0;

      if (_isAllEquipmentSelected(equipment)) {
        await fetchExercises();
        return;
      }

      await _filterExercises(selectedEquipment.value);
    } catch (e) {
      // Handle error silently
    } finally {
      isLoading(false);
    }
  }

  /// Load more exercises when scrolling
  Future<void> loadMoreExercises() async {
    if (_shouldFetchNewExercises) {
      await fetchExercises(isLoadMore: true);
    } else {
      await _loadMoreFilteredExercises();
    }
  }

  /// Fetch available equipment list
  Future<void> fetchEquipmentList() async {
    try {
      isLoading(true);
      final equipment = await _exerciseService.getEquipmentList();
      equipmentList
        ..value = equipment
        ..insert(0, AppKeys.all);
    } catch (e) {
      // Handle error silently
    } finally {
      isLoading(false);
    }
  }

  /// Fetch available target list based on selected body part
  Future<void> fetchTargetList() async {
    try {
      isLoading(true);

      // First get all exercises for the selected body part
      final bodyPartExercises = await _exerciseService.getExercisesByBodyPart(
        bodyPart,
        limit: 1000,
      );

      // Filter target muscles for the selected body part
      final targetSet =
          bodyPartExercises.map((exercise) => exercise.target).toSet();
      final targets = targetSet.toList()..sort();

      targetList
        ..value = targets
        ..insert(0, AppKeys.all);
    } catch (e) {
      // Handle error silently
    } finally {
      isLoading(false);
    }
  }

  /// Apply both equipment and target filters
  Future<void> applyFilters() async {
    try {
      isLoading(true);
      _offset = 0;

      if (_isAllFiltersSelected) {
        await fetchExercises();
        return;
      }

      await _filterExercises();
    } catch (e) {
      // Handle error silently
    } finally {
      isLoading(false);
    }
  }

  /// Update current page index
  // ignore: use_setters_to_change_properties
  void updatePageIndex(int index) => currentPageIndex.value = index;

  // Private helper methods

  void _setLoadingState(bool isLoadMore) {
    if (isLoadMore) {
      isLoadingMore(true);
      _offset += _pageLimit;
    } else {
      isLoading(true);
      _offset = 0;
      _clearExerciseLists();
    }
  }

  void _clearExerciseLists() {
    exercises.clear();
    filteredExercises.clear();
  }

  void _handleEmptyResponse(bool isLoadMore) {
    if (isLoadMore) {
      CustomFlushbar.showInfo(AppKeys.endOfTheList);
    }
  }

  void _updateExerciseLists(List<BaseObjectModel> newExercises) {
    exercises.addAll(newExercises);
    filteredExercises.addAll(newExercises);
  }

  void _resetLoadingState(bool isLoadMore) {
    if (isLoadMore) {
      isLoadingMore(false);
    } else {
      isLoading(false);
    }
  }

  bool get _shouldFetchNewExercises =>
      selectedEquipment.value.toLowerCase() == 'all' ||
      selectedEquipment.value.isEmpty;

  bool _isAllEquipmentSelected(String equipment) =>
      equipment.toLowerCase() == 'all';

  bool get _isAllFiltersSelected =>
      (selectedEquipment.value.isEmpty ||
          selectedEquipment.value.toLowerCase() == 'all') &&
      (selectedTarget.value.isEmpty ||
          selectedTarget.value.toLowerCase() == 'all');

  Future<void> _filterExercises([String? equipment]) async {
    final allExercises = await _exerciseService.getExercisesByBodyPart(
      bodyPart,
      limit: 1000,
    );

    final filteredList = allExercises.where((exercise) {
      if (equipment != null) {
        return exercise.equipment.toLowerCase() == equipment.toLowerCase();
      }
      return exercise.equipment.toLowerCase() ==
          selectedEquipment.value.toLowerCase();
    }).toList();

    final initialExercises = filteredList.take(_pageLimit).toList();
    exercises.assignAll(filteredList);
    filteredExercises.assignAll(initialExercises);
    _resetPageView();
  }

  Future<void> _loadMoreFilteredExercises() async {
    final start = filteredExercises.length;
    final end = start + _pageLimit;

    if (start >= exercises.length) {
      CustomFlushbar.showInfo(AppKeys.endOfTheList);
      return;
    }

    isLoadingMore(true);

    final nextExercises = exercises.sublist(
      start,
      end > exercises.length ? exercises.length : end,
    );

    filteredExercises.addAll(nextExercises);
    isLoadingMore(false);
  }

  void _resetPageView() {
    currentPageIndex.value = 0;
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
