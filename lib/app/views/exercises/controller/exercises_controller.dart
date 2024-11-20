import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:muscle_zone/app/models/api/base_object_model.dart';
import 'package:muscle_zone/app/services/api/exercise_service.dart';
import 'package:muscle_zone/app/services/cache/exercises_cache_service.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/utils/service_helper.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';

/// Controller class that manages exercise-related operations and states
class ExercisesController extends GetxController {
  /// Constructor for ExercisesController
  /// _exerciseService is the service responsible for exercise-related API calls
  /// _cacheService is the service responsible for caching exercises data
  /// bodyPart is the body part for which exercises are being fetched
  ExercisesController(
    this._exerciseService,
    this._cacheService, {
    required this.bodyPart,
  });

  final ExerciseService _exerciseService;
  final ExercisesCacheService _cacheService;
  final ServiceHelper _serviceHelper = ServiceHelper();

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
    try {
      await Future.wait([
        _fetchInitialExercises(),
        _fetchFilterOptions(),
      ]);
      _setupScrollListener();
    } finally {
      isLoading(false);
    }
  }

  /// Fetch initial data for exercises and filter options
  Future<void> _fetchInitialExercises() => fetchExercises();

  /// Fetch available filter options
  Future<void> _fetchFilterOptions() async {
    await Future.wait([
      _fetchAndCacheList('equipment', fetchEquipmentList, equipmentList),
      _fetchAndCacheList('target', fetchTargetList, targetList),
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
    await _toggleLoadingState(isLoadMore, true);

    if (!_isAllFiltersSelected) {
      final cachedExercises = _cacheService.getExercisesFromCache(bodyPart);
      if (cachedExercises != null && !isLoadMore) {
        _updateExerciseLists(cachedExercises);
        return;
      }
    }

    if (!isLoadMore) {
      await _serviceHelper.fetchData<BaseObjectModel>(
        fetchFunction: () => _exerciseService.getExercisesByBodyPart(
          bodyPart,
          offset: _offset,
        ),
        targetList: exercises,
        errorMessage: AppKeys.failedToLoadExercises,
        onSuccess: (data) {
          _updateExerciseLists(data);
          _cacheService.cacheExercisesByBodyPart(bodyPart, data);
        },
      );
    } else {
      await _serviceHelper.fetchData<BaseObjectModel>(
        fetchFunction: () => _exerciseService.getExercisesByBodyPart(
          bodyPart,
          offset: _offset,
        ),
        targetList: exercises,
        errorMessage: AppKeys.failedToLoadExercises,
        onSuccess: _addNewExercises,
      );
    }

    _offset += _pageLimit;
    await _toggleLoadingState(isLoadMore, false);
  }

  /// Fetch and cache a list of strings
  Future<void> _fetchAndCacheList(
    String cacheKey,
    Future<List<String>> Function() fetchFunction,
    RxList<String> list,
  ) async {
    final cachedList = _cacheService.getFilterListFromCache(cacheKey);
    if (cachedList != null) {
      _updateFilterList(list, cachedList);
      return;
    }

    final fetchedList = await fetchFunction();
    _updateFilterList(list, fetchedList);
    _cacheService.cacheFilterList(cacheKey, fetchedList);
  }

  /// Fetch equipment list
  Future<List<String>> fetchEquipmentList() async {
    return _exerciseService.getEquipmentList();
  }

  /// Fetch target list
  Future<List<String>> fetchTargetList() async {
    final exercises = await _exerciseService.getExercisesByBodyPart(
      bodyPart,
      limit: 1000,
    );

    return exercises.map((exercise) => exercise.target).toSet().toList()
      ..sort();
  }

  /// Apply selected filters
  Future<void> applyFilters() async {
    isLoading(true);
    _offset = 0;

    if (_isAllFiltersSelected) {
      await _resetToAllExercises();
    } else {
      await _applySelectedFilters();
    }

    isLoading(false);
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
    return _isFilterAll(selectedEquipment.value) ||
        exercise.equipment.toLowerCase() ==
            selectedEquipment.value.toLowerCase();
  }

  bool _matchesTargetFilter(BaseObjectModel exercise) {
    return _isFilterAll(selectedTarget.value) ||
        exercise.target.toLowerCase() == selectedTarget.value.toLowerCase();
  }

  void _updateFilterList(RxList<String> list, List<String> newItems) {
    list
      ..value = newItems
      ..insert(0, AppKeys.all);
  }

  void _updateExerciseLists(List<BaseObjectModel> newExercises) {
    exercises.value = newExercises;
    filteredExercises.value = newExercises;
  }

  void _updateFilteredExercises(List<BaseObjectModel> filteredList) {
    final initialExercises = filteredList.take(_pageLimit).toList();
    exercises.assignAll(filteredList);
    filteredExercises.assignAll(initialExercises);
  }

  bool _isFilterAll(String value) =>
      value.isEmpty || value.toLowerCase() == AppKeys.all.toLowerCase();

  void _clearExerciseLists() {
    exercises.clear();
    filteredExercises.clear();
  }

  Future<void> _toggleLoadingState(bool isLoadMore, bool state) async {
    if (isLoadMore) {
      isLoadingMore(state);
    } else {
      isLoading(state);
    }
  }

  bool get _isAllFiltersSelected =>
      _isFilterAll(selectedEquipment.value) &&
      _isFilterAll(selectedTarget.value);

  void _resetPageView() {
    if (pageController.hasClients) {
      pageController.jumpToPage(0);
    }
    currentPageIndex.value = 0;
    _offset = 0;
  }

  /// Load more exercises
  Future<void> loadMoreExercises() async {
    await fetchExercises(isLoadMore: true);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  /// Update the current page index
  // ignore: use_setters_to_change_properties
  void updatePageIndex(int index) {
    currentPageIndex.value = index;
  }

  /// Add new exercises to the list
  void _addNewExercises(List<BaseObjectModel> newExercises) {
    exercises.addAll(newExercises);
    filteredExercises.addAll(newExercises);
  }
}
