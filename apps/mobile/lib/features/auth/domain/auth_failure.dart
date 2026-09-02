/// Failure taxonomy for authentication flows.
///
/// The repository maps transport/module exceptions onto these cases; the
/// presentation layer maps them onto localized messages.
sealed class AuthFailure {
  const AuthFailure();
}

/// Wrong email or password.
final class InvalidCredentialsFailure extends AuthFailure {
  const InvalidCredentialsFailure();
}

/// Rate limit hit (too many login or reset attempts).
final class TooManyAttemptsFailure extends AuthFailure {
  const TooManyAttemptsFailure();
}

/// Password rejected by the server policy (min 8 chars, no outer whitespace).
final class PasswordPolicyFailure extends AuthFailure {
  const PasswordPolicyFailure();
}

/// Verification code wrong, expired, or unknown request id.
final class CodeInvalidOrExpiredFailure extends AuthFailure {
  const CodeInvalidOrExpiredFailure();
}

/// Server unreachable or returned an unexpected status.
final class NetworkFailure extends AuthFailure {
  const NetworkFailure();
}

/// Anything else the repository could not classify.
final class UnknownAuthFailure extends AuthFailure {
  const UnknownAuthFailure(this.detail);

  /// Technical detail for logs; never shown to users.
  final String detail;
}
