import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app_config.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

/// Single Serverpod client instance for the whole app. Endpoints are always
/// reached through this provider — never construct ad-hoc clients.
final serverpodClientProvider = Provider<Client>((ref) {
  final client = Client(ref.watch(appConfigProvider).serverUrl);
  ref.onDispose(client.close);
  return client;
});
