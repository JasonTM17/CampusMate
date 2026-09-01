import 'package:flutter_test/flutter_test.dart';

import 'package:campusmate/core/errors/failures.dart';
import 'package:campusmate/core/result/result.dart';

void main() {
  group('Result', () {
    test('success carries the value through fold', () {
      final result = Result<int>.success(42);

      final folded = result.fold(
        onSuccess: (value) => 'value=$value',
        onFailure: (failure) => 'failure=${failure.userMessage}',
      );

      expect(folded, 'value=42');
      expect(result.isSuccess, isTrue);
    });

    test('failure carries the failure through fold', () {
      const failure = NetworkFailure();
      final result = Result<int>.failure(failure);

      final folded = result.fold(
        onSuccess: (value) => 'value=$value',
        onFailure: (failure) => 'failure=${failure.userMessage}',
      );

      expect(folded, 'failure=Network error');
      expect(result.isSuccess, isFalse);
    });

    test('fold returns different result types', () {
      Result<String> ok = Result.success('data');
      Result<String> err = Result.failure(const ServerFailure());

      expect(ok.fold(onSuccess: (v) => v.length, onFailure: (_) => -1), 4);
      expect(err.fold(onSuccess: (v) => v.length, onFailure: (_) => -1), -1);
    });

    test('failure keeps the typed failure instance', () {
      const original = ForbiddenFailure();
      final result = Result<void>.failure(original);

      result.fold(
        onSuccess: (_) {},
        onFailure: (failure) {
          expect(identical(failure, original), isTrue);
        },
      );
    });

    test('pattern matching stays exhaustive over sealed subtypes', () {
      final List<Result<int>> results = [
        Result.success(1),
        Result.failure(const OfflineFailure()),
      ];

      final kinds = results
          .map(
            (r) => switch (r) {
              Success<int>() => 'success',
              AppError<int>() => 'error',
            },
          )
          .toList();

      expect(kinds, ['success', 'error']);
    });
  });
}
