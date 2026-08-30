import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter_test/flutter_test.dart';

/// Phase-01 spike evidence (A1): the Serverpod-generated client package
/// resolves, connects to the locally running server, and completes a
/// round-trip endpoint call. Requires `docker compose up -d` in `server/`
/// and the server booted with `dart run bin/main.dart --apply-migrations`.
void main() {
  test('generated client calls the live Serverpod greeting endpoint', () async {
    final client = Client('http://localhost:8080/');
    final greeting = await client.greeting.hello('CampusMate');
    expect(greeting.message, contains('CampusMate'));
    expect(greeting.author, 'Serverpod');
    client.close();
  });
}
