import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:muscle_zone/config/app_config.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/errors/api_exception.dart';
import 'package:muscle_zone/core/errors/error_handler.dart';

class ApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiClient()
      : baseUrl = dotenv.env[AppConfig.apiHost] ?? "",
        defaultHeaders = {
          AppConfig.rapidApiKey: dotenv.env[AppConfig.apiKey] ?? "",
          AppConfig.rapidApiHost: dotenv.env[AppConfig.apiHost] ?? "",
        };

  // Base GET Method
  Future<List<T>> get<T>({
    required String path,
    Map<String, String>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    // Combining paths
    final uri = Uri.https(
      baseUrl,
      "${DBConstants.path_exercises}$path",
      queryParameters,
    );

    try {
      final response = await http
          .get(uri, headers: defaultHeaders)
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        handleError(response);
      }
    } catch (e) {
      throw ApiException('Failed to fetch data', e.toString());
    }
    return [];
  }
}
