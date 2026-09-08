import 'package:campusmate/app/router/auth_redirects.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('preserves internal deep links through auth routes', () {
    final loginRoute = guardedAuthRouteFor(
      Uri.parse('/academic/exams/41'),
      loginPath,
    );

    expect(loginRoute, '/login?from=%2Facademic%2Fexams%2F41');
    expect(postAuthRouteFor(Uri.parse(loginRoute)), '/academic/exams/41');
  });

  test('rejects external and auth-flow redirect targets', () {
    expect(safeRedirectTarget('https://example.com'), isNull);
    expect(safeRedirectTarget('//example.com'), isNull);
    expect(safeRedirectTarget('/login'), isNull);
    expect(safeRedirectTarget('/auth-loading?from=/academic'), isNull);
  });
}
