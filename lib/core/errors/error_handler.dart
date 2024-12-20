import 'package:http/http.dart' as http;
import 'package:muscle_zone/core/errors/api_exception.dart';

/// Handles errors from HTTP responses and throws appropriate custom exceptions.
/// [response] represents the HTTP response to be processed.
void handleError(http.Response response) {
  switch (response.statusCode) {
    case 400:
      throw BadRequestException('Bad Request: ${response.body}');
    case 401:
      throw UnauthorizedException('Unauthorized: ${response.body}');
    case 500:
      throw ServerErrorException('Server Error: ${response.body}');
    default:
      throw ApiException(
        'Failed with status: ${response.statusCode} ${response.body}',
      );
  }
}
