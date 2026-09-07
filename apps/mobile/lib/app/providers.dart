import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/auth/data/auth_token_storage.dart';
import '../features/auth/data/session_auth_key_provider.dart';
import '../core/storage/campusmate_database.dart';
import 'config/app_config.dart';

final appConfigProvider = Provider<AppConfig>(
  (ref) => AppConfig.fromEnvironment(),
);

/// Provides the local auth token store (single instance).
final authTokenStorageProvider = Provider<AuthTokenStorage>(
  (ref) => AuthTokenStorage(),
);

final campusMateDatabaseProvider = Provider<CampusMateDatabase>((ref) {
  final database = CampusMateDatabase();
  ref.onDispose(database.close);
  return database;
});

/// Single Serverpod client instance for the whole app. Endpoints are always
/// reached through this provider — never construct ad-hoc clients. The
/// client carries the session bearer token via [SessionAuthKeyProvider],
/// which also transparently refreshes expired JWTs.
final serverpodClientProvider = Provider<Client>((ref) {
  final storage = ref.watch(authTokenStorageProvider);
  late final Client client;
  final authKeyProvider = SessionAuthKeyProvider(
    storage: storage,
    // The jwtRefresh endpoint is unauthenticated, so resolving this closure
    // cannot recurse into authHeaderValue.
    refreshTokens: (refreshToken) =>
        client.jwtRefresh.refreshAccessToken(refreshToken: refreshToken),
  );
  client = Client(ref.watch(appConfigProvider).serverUrl)
    ..authKeyProvider = authKeyProvider;
  ref.onDispose(client.close);
  return client;
});
