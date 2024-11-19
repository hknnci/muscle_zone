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
      _fetchInitialExercises(),
      _fetchFilterOptions(),
    ]);
    _setupScrollListener();
  }

  /// Fetch initial data for exercises and filter options
  Future<void> _fetchInitialExercises() => fetchExercises();

  /// Fetch available filter options
  Future<void> _fetchFilterOptions() async {
    await Future.wait([
      fetchEquipmentList(),
      fetchTargetList(),
    ]);
  }

  /// Setup scroll listener for pagination
  void _setupScrollListener() => pageController.addListener(_handleScroll);

  /// Handle pagination on scroll
  void _handleScroll() {
    if (_shouldLoadMore) {
      loadMoreExercises();
    }
  }

  /// Check if more items should be loaded
  bool get _shouldLoadMore =>
      pageController.position.atEdge &&
      pageController.position.pixels != 0 &&
      !isLoadingMore.value;

  /// Fetch exercises with pagination
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
    } finally {
      _resetLoadingState(isLoadMore);
    }
  }

  /// Fetch and setup equipment list
  Future<void> fetchEquipmentList() async {
    try {
      isLoading(true);
      final equipment = await _exerciseService.getEquipmentList();
      _updateFilterList(equipmentList, equipment);
    } finally {
      isLoading(false);
    }
  }

  /// Fetch and setup target list
  Future<void> fetchTargetList() async {
    try {
      isLoading(true);
      final exercises = await _exerciseService.getExercisesByBodyPart(
        bodyPart,
        limit: 1000,
      );

      final targets =
          exercises.map((exercise) => exercise.target).toSet().toList()..sort();

      _updateFilterList(targetList, targets);
    } finally {
      isLoading(false);
    }
  }

  /// Apply selected filters
  Future<void> applyFilters() async {
    try {
      isLoading(true);
      _offset = 0;

      if (_isAllFiltersSelected) {
        await _resetToAllExercises();
        return;
      }

      await _applySelectedFilters();
    } finally {
      isLoading(false);
    }
  }

  /// Reset to show all exercises
  Future<void> _resetToAllExercises() async {
    _clearExerciseLists();
    await fetchExercises();
    _resetPageView();
  }

  /// Apply currently selected filters
  Future<void> _applySelectedFilters() async {
    final allExercises = await _exerciseService.getExercisesByBodyPart(
      bodyPart,
      limit: 1000,
    );

    final filteredList = _filterExercises(allExercises);

    if (filteredList.isEmpty) {
      CustomFlushbar.showInfo(AppKeys.noExerciseInList);
      return;
    }

    _updateFilteredExercises(filteredList);
    _resetPageView();
  }

  /// Filter exercises based on selected criteria
  List<BaseObjectModel> _filterExercises(List<BaseObjectModel> exercises) {
    return exercises.where((exercise) {
      return _matchesEquipmentFilter(exercise) &&
          _matchesTargetFilter(exercise);
    }).toList();
  }

  /// Check if exercise matches equipment filter
  bool _matchesEquipmentFilter(BaseObjectModel exercise) {
    if (_isFilterAll(selectedEquipment.value)) return true;
    return exercise.equipment.toLowerCase() ==
        selectedEquipment.value.toLowerCase();
  }

  /// Check if exercise matches target filter
  bool _matchesTargetFilter(BaseObjectModel exercise) {
    if (_isFilterAll(selectedTarget.value)) return true;
    return exercise.target.toLowerCase() == selectedTarget.value.toLowerCase();
  }

  /// Helper Methods
  void _updateFilterList(RxList<String> list, List<String> newItems) {
    list
      ..value = newItems
      ..insert(0, AppKeys.all);
  }

  void _updateFilteredExercises(List<BaseObjectModel> filteredList) {
    final initialExercises = filteredList.take(_pageLimit).toList();
    exercises.assignAll(filteredList);
    filteredExercises.assignAll(initialExercises);
  }

  bool _isFilterAll(String value) =>
      value.isEmpty || value.toLowerCase() == AppKeys.all.toLowerCase();

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

  bool get _isAllFiltersSelected =>
      (selectedEquipment.value.isEmpty ||
          selectedEquipment.value.toLowerCase() == AppKeys.all.toLowerCase()) &&
      (selectedTarget.value.isEmpty ||
          selectedTarget.value.toLowerCase() == AppKeys.all.toLowerCase());

  void _resetPageView() {
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
    currentPageIndex.value = 0;
    _offset = 0;
  }

  /// Load more exercises for pagination
  Future<void> loadMoreExercises() async {
    await fetchExercises(isLoadMore: true);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Update current page index
  // ignore: use_setters_to_change_properties
  void updatePageIndex(int index) {
    currentPageIndex.value = index;
  }
}
