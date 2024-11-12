import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:muscle_zone/config/app_config.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/errors/api_exception.dart';
import 'package:muscle_zone/core/errors/error_handler.dart';
import 'package:muscle_zone/core/utils/json_converter.dart';

class ApiClient {
  final String baseUrl;
  final Map<String, String> defaultHeaders;

  ApiClient()
      : baseUrl = dotenv.env[AppConfig.apiHost] ?? "",
        defaultHeaders = {
          AppConfig.rapidApiKey: dotenv.env[AppConfig.apiKey] ?? "",
          AppConfig.rapidApiHost: dotenv.env[AppConfig.apiHost] ?? "",
        };

  /// GET method for list
  Future<List<T>> getList<T>({
    required String path,
    Map<String, String>? queryParameters,
  }) async {
    // Combining paths
    final uri = Uri.https(
      baseUrl,
      "${DBConstants.path_exercises}$path",
      queryParameters,
    );

    // for testing purposes
    // print('GET Request: $uri');
    // print('Headers: $defaultHeaders');

    try {
      final response = await http
          .get(uri, headers: defaultHeaders)
          .timeout(const Duration(seconds: 10));

      // for testing purposes
      // print('Response Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        // Automatically handle fromJson conversion
        if (T == String) {
          return data.cast<T>();
        } else {
          return data.map((item) => JsonConverter.fromJson<T>(item)).toList();
        }
      } else {
        handleError(response);
      }
    } catch (e) {
      throw ApiException('Failed to fetch data', e.toString());
    }
    return [];
  }

  /// GET method for single object
  Future<T> get<T>({
    required String path,
    Map<String, String>? queryParameters,
  }) async {
    final uri = Uri.https(
      baseUrl,
      "${DBConstants.path_exercises}$path",
      queryParameters,
    );

    // for testing purposes
    // print('GET Request: $uri');
    // print('Headers: $defaultHeaders');

    try {
      final response = await http
          .get(uri, headers: defaultHeaders)
          .timeout(const Duration(seconds: 10));

      // for testing purposes
      // print('Response Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        // Automatically handle fromJson conversion
        return JsonConverter.fromJson<T>(data);
      } else {
        handleError(response);
      }
    } catch (e) {
      throw ApiException('Failed to fetch data', e.toString());
    }

    throw ApiException('Failed to parse data');
  }
}
