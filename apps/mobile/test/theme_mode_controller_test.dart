import 'package:campusmate/app/theme/theme_mode_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('theme mode controller switches modes correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appThemeModeProvider), ThemeMode.system);

    container.read(appThemeModeProvider.notifier).setThemeMode(ThemeMode.dark);
    expect(container.read(appThemeModeProvider), ThemeMode.dark);

    container.read(appThemeModeProvider.notifier).setThemeMode(ThemeMode.light);
    expect(container.read(appThemeModeProvider), ThemeMode.light);
  });

  test('locale controller switches language correctly', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    expect(container.read(appLocaleProvider), const Locale('vi'));

    container.read(appLocaleProvider.notifier).setLocale(const Locale('en'));
    expect(container.read(appLocaleProvider), const Locale('en'));
  });
}
