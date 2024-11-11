class ApiException implements Exception {
  final String message;
  final String? details;

  ApiException(this.message, [this.details]);

  @override
  String toString() => "ApiException: $message ${details ?? ""}";
}

class BadRequestException extends ApiException {
  BadRequestException(String message) : super(message);
}

class UnauthorizedException extends ApiException {
  UnauthorizedException(String message) : super(message);
}

class ServerErrorException extends ApiException {
  ServerErrorException(String message) : super(message);
}
