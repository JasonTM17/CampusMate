import 'dart:io' show Platform;

/// Central app configuration.
///
/// Defaults to localhost on desktop/iOS and the Android emulator host bridge
/// on Android when `CAMPUSMATE_SERVER_URL` is not supplied.
class AppConfig {
  const AppConfig({required this.serverUrl});

  final String serverUrl;

  static AppConfig fromEnvironment() {
    const serverUrl = String.fromEnvironment('CAMPUSMATE_SERVER_URL');
    if (serverUrl.isNotEmpty) {
      return const AppConfig(serverUrl: serverUrl);
    }
    if (Platform.isAndroid) {
      return const AppConfig(serverUrl: 'http://10.0.2.2:8080/');
    }
    return const AppConfig(serverUrl: 'http://localhost:8080/');
  }
}
