import 'package:serverpod/serverpod.dart';

import '../auth/campusmate_auth.dart';

/// Small protected surface used by phase-02 to prove role isolation.
///
/// The real admin feature is delivered in phase-11; keeping this endpoint
/// narrow gives the auth phase a concrete server-side 403 contract now.
class AdminEndpoint extends Endpoint {
  @override
  Set<Scope> get requiredScopes => {campusMateAdminScope};

  Future<String> getAccessSummary(Session session) async {
    CampusMateAuth.requireScope(session, campusMateAdminScope);
    return 'admin-access-granted';
  }
}
