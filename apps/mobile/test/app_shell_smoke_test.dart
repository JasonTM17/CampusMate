import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/app/app.dart';

void main() {
  testWidgets('app boots into the 5-tab shell with Vietnamese default locale', (
    tester,
  ) async {
    await tester.pumpWidget(const ProviderScope(child: CampusMateApp()));
    await tester.pumpAndSettle();

    // Vietnamese is the default locale (§46).
    expect(find.text('Trang chủ'), findsWidgets);
    expect(find.text('Học tập'), findsOneWidget);
    expect(find.text('Thư viện'), findsOneWidget);
    expect(find.text('AI'), findsOneWidget);
    expect(find.text('Cá nhân'), findsOneWidget);

    // Switching branches keeps an honest placeholder, not fake content.
    await tester.tap(find.text('Thư viện'));
    await tester.pumpAndSettle();
    expect(find.text('Sắp ra mắt'), findsOneWidget);
  });
}
