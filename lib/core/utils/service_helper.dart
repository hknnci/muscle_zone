import 'package:get/get.dart';

class ServiceHelper {
  /// Generic fetch method for data fetching and assigning to RxList.
  Future<void> fetchData<T>({
    required Future<List<T>> Function() fetchFunction,
    required RxList<T> targetList,
    String errorMessage = "Failed to load data",
  }) async {
    try {
      final result = await fetchFunction();
      targetList.assignAll(result);
    } catch (e) {
      Get.snackbar("Error", errorMessage);
    }
  }
}
