/// Exception class representing errors that occur during API operations.
class ApiException implements Exception {
  /// Constructs an [ApiException] with the given message and optional details.
  ApiException(this.message, [this.details]);

  /// The error message
  final String message;

  /// Additional details about the error
  final String? details;

  @override
  String toString() => "ApiException: $message ${details ?? ""}";
}

/// Exception thrown when the API request is malformed or invalid.
class BadRequestException extends ApiException {
  /// Constructs a [BadRequestException] with the given message.
  BadRequestException(super.message);
}

/// Exception thrown when the API request fails
/// due to authentication or authorization issues.
class UnauthorizedException extends ApiException {
  /// Constructs an [UnauthorizedException] with the given message.
  UnauthorizedException(super.message);
}

/// Exception thrown when the server returns a 5xx error response.
class ServerErrorException extends ApiException {
  /// Constructs a [ServerErrorException] with the given message.
  ServerErrorException(super.message);
}
