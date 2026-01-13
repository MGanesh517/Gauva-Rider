import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class Environment {
  static const String dev = 'development';
  static const String prod = 'production';
  static const String _prodUrl = 'https://gauva-f6f6d9ddagfqc9fw.canadacentral-01.azurewebsites.net';
  static const String _devUrl = 'https://gauva-f6f6d9ddagfqc9fw.canadacentral-01.azurewebsites.net';

  // Firebase Configuration (from google-services.json)
  static const String FIREBASE_API_KEY = 'AIzaSyCv2Lm4K4AETbK5Snzm7NwPBx89IBQv3j0';
  static const String FIREBASE_PROJECT_ID = 'gauva-15d9a';
  static const String FIREBASE_PROJECT_NUMBER = '798219755346';
  static const String FIREBASE_STORAGE_BUCKET = 'gauva-15d9a.firebasestorage.app';
  static const String FIREBASE_DATABASE_URL = 'https://gauva-15d9a-default-rtdb.firebaseio.com';

  // Google OAuth Web Client ID (client_type: 3 - Web Application)
  static const String GOOGLE_WEB_CLIENT_ID = '798219755346-ocqss3oc88fhrjtk0j8rem397ihjeabd.apps.googleusercontent.com';

  static const EnvironmentType currentEnvironment = EnvironmentType.prod;

  static String? _overrideApiUrl;

  /// Allows runtime override of the API base URL
  static void setApiUrlOverride(String url) {
    _overrideApiUrl = url;
  }

  static String get apiUrl {
    var base = baseUrl;
    // Ensure no trailing slash
    if (base.endsWith('/')) {
      base = base.substring(0, base.length - 1);
    }
    // Ensure no /api suffix since endpoints include it
    if (base.endsWith('/api')) {
      base = base.substring(0, base.length - 4);
    }
    return base;
  }

  static String get baseUrl {
    if (_overrideApiUrl != null) return _overrideApiUrl!;

    // Allow .env to override, otherwise use defaults
    final envUrl = dotenv.env['API_BASE_URL'];
    if (envUrl != null && envUrl.isNotEmpty) return envUrl;

    switch (currentEnvironment) {
      case EnvironmentType.dev:
        return _devUrl;
      case EnvironmentType.prod:
        return _prodUrl;
    }
  }

  /// WebSocket URL for raw WebSocket connections
  static String get webSocketUrl {
    final base = baseUrl;
    // Convert https:// to wss:// and http:// to ws://
    final wsUrl = base.startsWith('https')
        ? base.replaceFirst('https://', 'wss://')
        : base.replaceFirst('http://', 'ws://');
    // WebSocket endpoint - typically /ws for Spring Boot
    return '$wsUrl/ws';
  }
}
