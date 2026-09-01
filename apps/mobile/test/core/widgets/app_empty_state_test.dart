import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/core/widgets/app_empty_state.dart';

Widget _host(Widget child) => MaterialApp(home: Scaffold(body: child));

void main() {
  group('AppEmptyState', () {
    testWidgets('renders icon, title and message', (tester) async {
      await tester.pumpWidget(
        _host(
          const AppEmptyState(
            icon: Icons.inbox_outlined,
            title: 'Chưa có sách',
            message: 'Danh sách sẽ hiển thị sau khi đồng bộ.',
          ),
        ),
      );

      expect(find.byIcon(Icons.inbox_outlined), findsOneWidget);
      expect(find.text('Chưa có sách'), findsOneWidget);
      expect(
        find.text('Danh sách sẽ hiển thị sau khi đồng bộ.'),
        findsOneWidget,
      );
      expect(find.byType(FilledButton), findsNothing);
    });

    testWidgets('shows the action button only when fully configured', (
      tester,
    ) async {
      // Label without callback must not render a dead button.
      await tester.pumpWidget(
        _host(
          const AppEmptyState(
            icon: Icons.refresh,
            title: 't',
            message: 'm',
            actionLabel: 'Thử lại',
          ),
        ),
      );
      expect(find.byType(FilledButton), findsNothing);

      var tapped = false;
      await tester.pumpWidget(
        _host(
          AppEmptyState(
            icon: Icons.refresh,
            title: 't',
            message: 'm',
            actionLabel: 'Thử lại',
            onAction: () => tapped = true,
          ),
        ),
      );

      expect(find.byType(FilledButton), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      expect(tapped, isTrue);
    });

    testWidgets('keeps content centered and compact', (tester) async {
      await tester.pumpWidget(
        _host(
          const AppEmptyState(
            icon: Icons.search_off,
            title: 'Không tìm thấy',
            message: 'Từ khóa khác nhé?',
          ),
        ),
      );

      final column = tester.widget<Column>(
        find.descendant(
          of: find.byType(AppEmptyState),
          matching: find.byType(Column),
        ),
      );
      expect(column.mainAxisSize, MainAxisSize.min);

      final center = tester.widget<Center>(
        find.ancestor(
          of: find.text('Không tìm thấy'),
          matching: find.byType(Center),
        ),
      );
      expect(center, isNotNull);
    });
  });
}
