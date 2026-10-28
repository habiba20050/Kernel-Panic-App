class AppConstants {
  AppConstants._();

  static const String appName = 'Kernel Panic';
  static const String appVersion = '1.0.0';

  // Shared Preferences keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'current_user';

  // Timeouts
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Pagination
  static const int defaultPageSize = 20;
  static const int firstPage = 1;

  // Asset paths
  static const String imagesPath = 'assets/images';
  static const String iconsPath = 'assets/icons';
  static const String animationsPath = 'assets/animations';
}
