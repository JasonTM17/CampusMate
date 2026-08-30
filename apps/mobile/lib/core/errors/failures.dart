/// Typed failures mapped from server/network errors. `userMessage` must be
/// safe to show in the UI (§38/§79); technical details stay in logs only.
sealed class Failure {
  const Failure(this.userMessage);

  final String userMessage;

  @override
  String toString() => '$runtimeType($userMessage)';
}

final class NetworkFailure extends Failure {
  const NetworkFailure({String message = 'Network error'}) : super(message);
}

final class OfflineFailure extends Failure {
  const OfflineFailure({String message = 'You are offline'}) : super(message);
}

final class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({String message = 'Session expired'})
    : super(message);
}

final class ForbiddenFailure extends Failure {
  const ForbiddenFailure({String message = 'Not allowed'}) : super(message);
}

final class ValidationFailure extends Failure {
  const ValidationFailure({String message = 'Invalid input'}) : super(message);
}

final class NotFoundFailure extends Failure {
  const NotFoundFailure({String message = 'Not found'}) : super(message);
}

final class ServerFailure extends Failure {
  const ServerFailure({String message = 'Server error'}) : super(message);
}
