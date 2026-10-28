import '../constants/api_constants.dart';

/// Placeholder for the HTTP client wrapper.
/// Replace the body with your preferred HTTP package (e.g. dio, http).
class ApiClient {
  ApiClient._();

  static final ApiClient _instance = ApiClient._();
  static ApiClient get instance => _instance;

  // TODO: initialise your HTTP client here (e.g. Dio).
  // Example with dio:
  //
  // final Dio _dio = Dio(BaseOptions(
  //   baseUrl: ApiConstants.apiBaseUrl,
  //   connectTimeout: AppConstants.connectTimeout,
  //   receiveTimeout: AppConstants.receiveTimeout,
  //   headers: {
  //     ApiConstants.contentTypeHeader: ApiConstants.applicationJson,
  //   },
  // ));

  String get baseUrl => ApiConstants.apiBaseUrl;
}
