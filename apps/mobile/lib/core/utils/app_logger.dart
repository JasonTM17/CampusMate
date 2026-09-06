import 'package:flutter/foundation.dart';

enum LogLevel { debug, info, warning, error }

typedef LogSink = void Function(String message);

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

  void warning(
    String message, {
    Map<String, Object?> context = const {},
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    LogLevel.warning,
    message,
    context: context,
    error: error,
    stackTrace: stackTrace,
  );

  void error(
    String message, {
    Map<String, Object?> context = const {},
    Object? error,
    StackTrace? stackTrace,
  }) => log(
    LogLevel.error,
    message,
    context: context,
    error: error,
    stackTrace: stackTrace,
  );
}

class ConsoleAppLogger extends AppLogger {
  ConsoleAppLogger({LogSink? sink}) : _sink = sink ?? _defaultSink;

  /// Matched against lower-cased context keys, so `Password`, `accessToken`,
  /// `API_KEY` and snake_case variants are all caught.
  static const _sensitiveKeys = {
    'password',
    'token',
    'accesstoken',
    'access_token',
    'refreshtoken',
    'refresh_token',
    'apikey',
    'api_key',
    'secret',
    'signedurl',
    'signed_url',
    'authorization',
  };

  final LogSink _sink;

  static void _defaultSink(String message) {
    debugPrint(message);
  }

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
      (k, v) => MapEntry(
        k,
        _sensitiveKeys.contains(k.toLowerCase()) ? '«redacted»' : v,
      ),
    );
    _sink(
      '[${level.name.toUpperCase()}] $message'
      '${scrubbed.isEmpty ? '' : ' $scrubbed'}'
      '${error == null ? '' : ' error=$error'}'
      '${stackTrace == null ? '' : '\n$stackTrace'}',
    );
  }
}

final AppLogger appLogger = ConsoleAppLogger();
