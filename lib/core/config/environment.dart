import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class Environment {
  static const String dev = 'development';
  static const String prod = 'production';
  static final String _baseUrl =
      dotenv.env['API_BASE_URL'] ?? 'https://gauva-f6f6d9ddagfqc9fw.canadacentral-01.azurewebsites.net';

  static const EnvironmentType currentEnvironment = EnvironmentType.dev;

  static String? _overrideApiUrl;

  /// Allows runtime override of the API base URL
  static void setApiUrlOverride(String url) {
    _overrideApiUrl = url;
  }

  static String get apiUrl {
    if (_overrideApiUrl != null) {
      // Ensure no trailing slash
      return _overrideApiUrl!.endsWith('/')
          ? _overrideApiUrl!.substring(0, _overrideApiUrl!.length - 1)
          : _overrideApiUrl!;
    }
    // Spring Boot API endpoints already include /api/ prefix, so return base URL without /api/
    // Ensure base URL has no trailing slash for proper path concatenation
    final url = _baseUrl.endsWith('/') ? _baseUrl.substring(0, _baseUrl.length - 1) : _baseUrl;
    switch (currentEnvironment) {
      case EnvironmentType.dev:
        return url;
      case EnvironmentType.prod:
        return url;
    }
  }

  static String get baseUrl {
    if (_overrideApiUrl != null) return _overrideApiUrl!;
    switch (currentEnvironment) {
      case EnvironmentType.dev:
        return _baseUrl;
      case EnvironmentType.prod:
        return _baseUrl;
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
