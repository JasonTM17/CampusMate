import 'dart:io' show Platform;

/// Central app configuration.
///
/// Defaults to localhost on desktop/iOS and the Android emulator host bridge
/// on Android when `CAMPUSMATE_SERVER_URL` is not supplied.
class AppConfig {
  const AppConfig({required this.serverUrl});

  final String serverUrl;

  static AppConfig fromEnvironment({bool? isAndroid}) {
    const serverUrl = String.fromEnvironment('CAMPUSMATE_SERVER_URL');
    final normalized = normalizeServerUrl(serverUrl);
    if (normalized.isNotEmpty) {
      return AppConfig(serverUrl: normalized);
    }
    if (isAndroid ?? Platform.isAndroid) {
      return const AppConfig(serverUrl: 'http://10.0.2.2:8080/');
    }
    return const AppConfig(serverUrl: 'http://localhost:8080/');
  }

  static String normalizeServerUrl(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return '';
    }
    if (trimmed.endsWith('/')) {
      return trimmed;
    }
    return '$trimmed/';
  }
}
