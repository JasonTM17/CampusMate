import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

/// Logging boundary. Production rules (§50/§59): never log passwords,
/// tokens, AI keys or signed URLs. `context` values are scrubbed for
/// sensitive keys as a last line of defense — callers must still avoid
/// passing secrets at all.
abstract class AppLogger {
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  });

  void debug(String message, {Map<String, Object?> context = const {}}) =>
      log(LogLevel.debug, message, context: context);

  void info(String message, {Map<String, Object?> context = const {}}) =>
      log(LogLevel.info, message, context: context);

  void warning(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.warning, message, error: error, stackTrace: stackTrace);

  void error(String message, {Object? error, StackTrace? stackTrace}) =>
      log(LogLevel.error, message, error: error, stackTrace: stackTrace);
}

class ConsoleAppLogger extends AppLogger {
  static const _sensitiveKeys = {
    'password',
    'token',
    'accessToken',
    'refreshToken',
    'apiKey',
    'signedUrl',
    'authorization',
  };

  @override
  void log(
    LogLevel level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
    Map<String, Object?> context = const {},
  }) {
    if (!kDebugMode && level == LogLevel.debug) return;
    final scrubbed = context.map(
      (k, v) => MapEntry(k, _sensitiveKeys.contains(k) ? '«redacted»' : v),
    );
    // ignore: avoid_print
    print(
      '[${level.name.toUpperCase()}] $message'
      '${scrubbed.isEmpty ? '' : ' $scrubbed'}'
      '${error == null ? '' : ' error=$error'}',
    );
  }
}

final AppLogger appLogger = ConsoleAppLogger();
