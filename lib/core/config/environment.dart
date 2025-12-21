import 'package:flutter_dotenv/flutter_dotenv.dart';

enum EnvironmentType { dev, prod }

class Environment {
  static const String dev = 'development';
  static const String prod = 'production';
  static const String _prodUrl = 'https://gauva-f6f6d9ddagfqc9fw.southindia-01.azurewebsites.net';
  static const String _devUrl = 'https://gauva-f6f6d9ddagfqc9fw.canadacentral-01.azurewebsites.net';

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
