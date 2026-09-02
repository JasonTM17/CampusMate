// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'CampusMate';

  @override
  String get navHome => 'Home';

  @override
  String get navAcademic => 'Academic';

  @override
  String get navLibrary => 'Library';

  @override
  String get navAi => 'AI';

  @override
  String get navProfile => 'Profile';

  @override
  String get homeTagline => 'Study. Read. Grow.';

  @override
  String get comingSoonTitle => 'Coming soon';

  @override
  String get comingSoonMessage =>
      'This section is delivered in an upcoming phase of the roadmap.';

  @override
  String get retry => 'Retry';

  @override
  String get errorGeneric => 'Something went wrong. Please try again.';

  @override
  String get emptyGeneric => 'Nothing here yet.';

  @override
  String get authSignIn => 'Sign in';

  @override
  String get authSigningIn => 'Signing in…';

  @override
  String get authSubmitting => 'Submitting…';

  @override
  String get authLoginTitle => 'Welcome back';

  @override
  String get authLoginSubtitle =>
      'Sign in to use your CampusMate AI assistant.';

  @override
  String get authEmailLabel => 'Email';

  @override
  String get authEmailInvalid => 'Enter a valid email address.';

  @override
  String get authPasswordLabel => 'Password';

  @override
  String get authPasswordEmpty => 'Enter your password.';

  @override
  String get authNewPasswordLabel => 'New password';

  @override
  String get authConfirmPasswordLabel => 'Confirm password';

  @override
  String get authTogglePasswordVisibility => 'Show or hide password';

  @override
  String get authSignInButton => 'Sign in';

  @override
  String get authCreateAccount => 'Create account';

  @override
  String get authNoAccountYet => 'No account yet? Create one';

  @override
  String get authAlreadyHaveAccount => 'Already have an account? Sign in';

  @override
  String get authRegisterEmailStep => 'Step 1 · Email';

  @override
  String get authRegisterCodeStep => 'Step 2 · Verification code';

  @override
  String get authRegisterPasswordStep => 'Step 3 · Set password';

  @override
  String get authRegisterEmailHelp =>
      'We will send a verification code to this address.';

  @override
  String get authRegisterCodeHelp =>
      'Enter the verification code sent to your email.';

  @override
  String get authRegisterCodeHint => 'Verification code';

  @override
  String get authSendCode => 'Send code';

  @override
  String get authVerifyCode => 'Verify code';

  @override
  String get authFinishRegistration => 'Create account and sign in';

  @override
  String get authPasswordTooShort => 'Password must be at least 8 characters.';

  @override
  String get authPasswordWhitespace =>
      'Password cannot start or end with spaces.';

  @override
  String get authPasswordMismatch => 'Passwords do not match.';

  @override
  String get errorInvalidCredentials => 'Email or password is incorrect.';

  @override
  String get errorTooManyAttempts =>
      'Too many attempts. Please try again later.';

  @override
  String get errorPasswordPolicy =>
      'Password does not meet the requirements (min 8 characters).';

  @override
  String get errorCodeInvalid =>
      'The verification code is wrong or has expired.';

  @override
  String get errorNetwork =>
      'Cannot reach the server. Check your connection and try again.';

  @override
  String get chatSuggestions => 'What would you like to ask?';

  @override
  String get chatInputHint => 'Type your message...';

  @override
  String get chatSend => 'Send';

  @override
  String get chatTyping => 'Assistant is typing';

  @override
  String get chatConversationList => 'Conversations';
}
