import 'package:get/get.dart';
import 'package:muscle_zone/core/constants/app_keys.dart';
import 'package:muscle_zone/core/widgets/progress/custom_flushbar.dart';
import 'package:muscle_zone/core/errors/api_exception.dart';

class ServiceHelper {
  /// Generic fetch method for data fetching and assigning to RxList.
  Future<void> fetchData<T>({
    required Future<List<T>> Function() fetchFunction,
    required RxList<T> targetList,
    String? errorMessage,
  }) async {
    try {
      final result = await fetchFunction();
      targetList.assignAll(result);
    } catch (e) {
      if (e is ApiException) {
        // If it's a custom ApiException, show the detailed error message
        CustomFlushbar.showError("${e.message}: ${e.details ?? ''}");
      } else {
        // For any other error, show the default error message
        CustomFlushbar.showError(errorMessage ?? AppKeys.fetchDataError);
      }
    }
  }
}
