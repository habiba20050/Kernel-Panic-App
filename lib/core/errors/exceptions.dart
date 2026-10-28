/// Base class for all data-layer exceptions.
class AppException implements Exception {
  final String message;
  const AppException(this.message);

  @override
  String toString() => 'AppException(message: $message)';
}

class ServerException extends AppException {
  final int? statusCode;
  const ServerException(super.message, {this.statusCode});
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection.']);
}

class CacheException extends AppException {
  const CacheException([super.message = 'Cache read/write failed.']);
}

class AuthException extends AppException {
  const AuthException([super.message = 'Authentication failed.']);
}
