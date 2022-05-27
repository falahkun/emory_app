class ServerException implements Exception {}

class RequestException implements Exception {
  final String message;

  RequestException(this.message);
}
