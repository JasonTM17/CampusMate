/// Central app configuration. Values come from compile-time defines so no
/// environment-specific URL is hard-coded in feature code.
class AppConfig {
  const AppConfig({required this.serverUrl});

  final String serverUrl;

  static AppConfig fromEnvironment() => AppConfig(
    serverUrl: const String.fromEnvironment(
      'CAMPUSMATE_SERVER_URL',
      defaultValue: 'http://localhost:8080/',
    ),
  );
}
