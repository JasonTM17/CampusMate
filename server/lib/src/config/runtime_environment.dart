import 'dart:io';

/// Reads runtime configuration from the process environment first, then from
/// a local `.env` file. The server usually runs from `server/`, while the
/// template lives at the workspace root, so both `.env` and `../.env` are
/// checked.
String? readRuntimeEnvironmentValue(
  String key, {
  Map<String, String>? environment,
  String? dotenvContent,
}) {
  final fromProcess = (environment ?? Platform.environment)[key];
  if (fromProcess != null && fromProcess.trim().isNotEmpty) {
    return fromProcess.trim();
  }

  final content = dotenvContent ?? _readDotenvContent();
  if (content == null) return null;
  return _readDotenvValue(content, key);
}

String? _dotenvCache;

String? _readDotenvContent() {
  final cached = _dotenvCache;
  if (cached != null) return cached;

  for (final path in const ['.env', '../.env']) {
    final file = File(path);
    if (file.existsSync()) {
      return _dotenvCache = file.readAsStringSync();
    }
  }
  return _dotenvCache = '';
}

String? _readDotenvValue(String content, String key) {
  for (final rawLine in content.split('\n')) {
    var line = rawLine.trim();
    if (line.isEmpty || line.startsWith('#')) continue;
    if (line.startsWith('export ')) {
      line = line.substring('export '.length).trimLeft();
    }
    final separator = line.indexOf('=');
    if (separator <= 0) continue;
    final name = line.substring(0, separator).trim();
    if (name != key) continue;
    final parsed = _stripMatchingQuotes(line.substring(separator + 1).trim());
    return parsed.isEmpty ? null : parsed;
  }
  return null;
}

String _stripMatchingQuotes(String value) {
  if (value.length < 2) return value;
  final first = value[0];
  final last = value[value.length - 1];
  if ((first == '"' && last == '"') || (first == "'" && last == "'")) {
    return value.substring(1, value.length - 1);
  }
  return value;
}
