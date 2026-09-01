import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// Guards translation integrity: every user-facing key present in the
/// Vietnamese arb must exist in English and vice versa. Phase 01 shipped vi
/// as default and en as secondary (ADR); silent key drift between them is a
/// runtime crash (`AppLocalizations` throws on missing lookups) or a
/// hard-coded English fallback leaking into the vi UI.
void main() {
  Map<String, dynamic> loadArb(String locale) {
    final file = File('lib/l10n/app_$locale.arb');
    expect(
      file.existsSync(),
      isTrue,
      reason: 'missing lib/l10n/app_$locale.arb',
    );
    return jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  }

  /// Keys users can look up — drops `@@locale` directive and `@key` metadata.
  Set<String> userFacingKeys(Map<String, dynamic> arb) => arb.keys
      .where((key) => !key.startsWith('@') && key != '@@locale')
      .toSet();

  test('@@locale directive matches the file it lives in', () {
    expect(loadArb('vi')['@@locale'], 'vi');
    expect(loadArb('en')['@@locale'], 'en');
  });

  test('vi and en expose exactly the same user-facing keys', () {
    final viKeys = userFacingKeys(loadArb('vi'));
    final enKeys = userFacingKeys(loadArb('en'));

    expect(
      viKeys.difference(enKeys),
      isEmpty,
      reason: 'keys missing from app_en.arb: ${viKeys.difference(enKeys)}',
    );
    expect(
      enKeys.difference(viKeys),
      isEmpty,
      reason: 'keys missing from app_vi.arb: ${enKeys.difference(viKeys)}',
    );
  });

  test('no translation value is empty or blank', () {
    for (final locale in ['vi', 'en']) {
      final arb = loadArb(locale);
      for (final key in userFacingKeys(arb)) {
        final value = arb[key];
        expect(value, isA<String>(), reason: '$locale/$key must be a string');
        expect(
          (value as String).trim(),
          isNotEmpty,
          reason: '$locale/$key is blank',
        );
      }
    }
  });

  test('navigation labels stay present in both locales', () {
    const navKeys = [
      'navHome',
      'navAcademic',
      'navLibrary',
      'navAi',
      'navProfile',
    ];
    for (final locale in ['vi', 'en']) {
      expect(
        loadArb(locale).keys,
        containsAll(navKeys),
        reason: '$locale arb lost a navigation key',
      );
    }
  });
}
