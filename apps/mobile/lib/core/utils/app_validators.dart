/// Shared form validators used by the auth and profile flows.
abstract final class AppValidators {
  static final RegExp _email = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  /// Requires a full `local@domain.tld` shape; a bare `contains('@')` check
  /// accepts inputs like `a@` that the server would reject anyway.
  static String? email(String? value, String Function() invalidMessage) {
    final email = value?.trim() ?? '';
    if (email.isEmpty || !_email.hasMatch(email)) {
      return invalidMessage();
    }
    return null;
  }
}
