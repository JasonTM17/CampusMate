const authLoadingPath = '/auth-loading';
const loginPath = '/login';
const registerPath = '/register';
const resetPasswordPath = '/reset-password';

const _authFlowPaths = <String>{
  authLoadingPath,
  loginPath,
  registerPath,
  resetPasswordPath,
};

bool isAuthScreenPath(String path) =>
    path == loginPath || path == registerPath || path == resetPasswordPath;

bool isAuthFlowPath(String path) => _authFlowPaths.contains(path);

String guardedAuthRouteFor(Uri currentUri, String authPath) {
  final target = _redirectTargetFor(currentUri);
  if (target == null) return authPath;
  return Uri(path: authPath, queryParameters: {'from': target}).toString();
}

String authRouteWithCurrentFrom(Uri currentUri, String authPath) =>
    guardedAuthRouteFor(currentUri, authPath);

String postAuthRouteFor(Uri currentUri, {String fallback = '/home'}) {
  return safeRedirectTarget(currentUri.queryParameters['from']) ?? fallback;
}

String? safeRedirectTarget(String? raw) {
  if (raw == null || raw.isEmpty) return null;
  final uri = Uri.tryParse(raw);
  if (uri == null || uri.hasScheme || uri.hasAuthority) return null;
  final path = uri.path;
  if (!path.startsWith('/') || path.startsWith('//')) return null;
  if (isAuthFlowPath(path)) return null;
  return uri.toString();
}

String? _redirectTargetFor(Uri currentUri) {
  final from = safeRedirectTarget(currentUri.queryParameters['from']);
  if (from != null) return from;
  return safeRedirectTarget(_locationWithoutAuthFrom(currentUri));
}

String _locationWithoutAuthFrom(Uri uri) {
  final path = uri.path.isEmpty ? '/home' : uri.path;
  final query = Map<String, String>.of(uri.queryParameters)..remove('from');
  return Uri(
    path: path,
    queryParameters: query.isEmpty ? null : query,
  ).toString();
}
