class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://api.kernelpanic.dev';
  static const String apiVersion = '/v1';

  static String get apiBaseUrl => '$baseUrl$apiVersion';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Headers
  static const String authorizationHeader = 'Authorization';
  static const String contentTypeHeader = 'Content-Type';
  static const String applicationJson = 'application/json';
  static const String bearerPrefix = 'Bearer ';
}
