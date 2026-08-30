import '../errors/failures.dart';

/// Result type for repository/domain boundaries: success value or typed
/// failure — never an uncaught exception crossing a layer.
sealed class Result<T> {
  const Result();

  factory Result.success(T value) = Success<T>;
  factory Result.failure(Failure failure) = AppError<T>;

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) => switch (this) {
    Success<T>(:final value) => onSuccess(value),
    AppError<T>(:final failure) => onFailure(failure),
  };

  bool get isSuccess => this is Success<T>;
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
}

final class AppError<T> extends Result<T> {
  const AppError(this.failure);
  final Failure failure;
}
