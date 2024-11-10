import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:muscle_zone/config/app_config.dart';
import 'package:muscle_zone/core/constants/db_constants.dart';

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

    final response = await http.get(uri, headers: defaultHeaders);

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data
          .map((json) => fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("Failed to load data: ${response.statusCode}");
    }
  }
}
