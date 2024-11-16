import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:muscle_zone/config/app_config.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';
import 'package:muscle_zone/core/errors/api_exception.dart';
import 'package:muscle_zone/core/errors/error_handler.dart';
import 'package:muscle_zone/core/utils/json_converter.dart';

/// Client class used for managing API requests.
/// Configured with [baseUrl] and [defaultHeaders].
class ApiClient {
  /// Constructs an [ApiClient] with the given base URL and default headers.
  ApiClient()
      : baseUrl = dotenv.env[AppConfig.apiHost] ?? '',
        defaultHeaders = {
          AppConfig.rapidApiKey: dotenv.env[AppConfig.apiKey] ?? '',
          AppConfig.rapidApiHost: dotenv.env[AppConfig.apiHost] ?? '',
        };

  /// The base URL for API requests
  final String baseUrl;

  /// The default headers for API requests
  final Map<String, String> defaultHeaders;

  /// GET method for list
  Future<List<T>> getList<T>({
    required String path,
    Map<String, String>? queryParameters,
  }) async {
    // Combining paths
    final uri = Uri.https(
      baseUrl,
      '${DBConstants.path_exercises}$path',
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
        final data = jsonDecode(response.body) as List<dynamic>;

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
      '${DBConstants.path_exercises}$path',
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
        final data = jsonDecode(response.body) as Map<String, dynamic>;

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
