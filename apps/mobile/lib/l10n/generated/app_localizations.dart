import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'CampusMate'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navAcademic.
  ///
  /// In en, this message translates to:
  /// **'Academic'**
  String get navAcademic;

  /// No description provided for @navLibrary.
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get navLibrary;

  /// No description provided for @navAi.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get navAi;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @homeTagline.
  ///
  /// In en, this message translates to:
  /// **'Study. Read. Grow.'**
  String get homeTagline;

  /// No description provided for @comingSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get comingSoonTitle;

  /// No description provided for @comingSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'This section is delivered in an upcoming phase of the roadmap.'**
  String get comingSoonMessage;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @errorGeneric.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get errorGeneric;

  /// No description provided for @emptyGeneric.
  ///
  /// In en, this message translates to:
  /// **'Nothing here yet.'**
  String get emptyGeneric;

  /// No description provided for @authSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignIn;

  /// No description provided for @authSigningIn.
  ///
  /// In en, this message translates to:
  /// **'Signing in…'**
  String get authSigningIn;

  /// No description provided for @authSubmitting.
  ///
  /// In en, this message translates to:
  /// **'Submitting…'**
  String get authSubmitting;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to use your CampusMate AI assistant.'**
  String get authLoginSubtitle;

  /// No description provided for @authEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// No description provided for @authEmailInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get authEmailInvalid;

  /// No description provided for @authPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// No description provided for @authPasswordEmpty.
  ///
  /// In en, this message translates to:
  /// **'Enter your password.'**
  String get authPasswordEmpty;

  /// No description provided for @authNewPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authNewPasswordLabel;

  /// No description provided for @authConfirmPasswordLabel.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPasswordLabel;

  /// No description provided for @authTogglePasswordVisibility.
  ///
  /// In en, this message translates to:
  /// **'Show or hide password'**
  String get authTogglePasswordVisibility;

  /// No description provided for @authSignInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInButton;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authCreateAccount;

  /// No description provided for @authNoAccountYet.
  ///
  /// In en, this message translates to:
  /// **'No account yet? Create one'**
  String get authNoAccountYet;

  /// No description provided for @authAlreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get authAlreadyHaveAccount;

  /// No description provided for @authRegisterEmailStep.
  ///
  /// In en, this message translates to:
  /// **'Step 1 · Email'**
  String get authRegisterEmailStep;

  /// No description provided for @authRegisterCodeStep.
  ///
  /// In en, this message translates to:
  /// **'Step 2 · Verification code'**
  String get authRegisterCodeStep;

  /// No description provided for @authRegisterPasswordStep.
  ///
  /// In en, this message translates to:
  /// **'Step 3 · Set password'**
  String get authRegisterPasswordStep;

  /// No description provided for @authRegisterEmailHelp.
  ///
  /// In en, this message translates to:
  /// **'We will send a verification code to this address.'**
  String get authRegisterEmailHelp;

  /// No description provided for @authRegisterCodeHelp.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your email.'**
  String get authRegisterCodeHelp;

  /// No description provided for @authRegisterCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get authRegisterCodeHint;

  /// No description provided for @authSendCode.
  ///
  /// In en, this message translates to:
  /// **'Send code'**
  String get authSendCode;

  /// No description provided for @authVerifyCode.
  ///
  /// In en, this message translates to:
  /// **'Verify code'**
  String get authVerifyCode;

  /// No description provided for @authFinishRegistration.
  ///
  /// In en, this message translates to:
  /// **'Create account and sign in'**
  String get authFinishRegistration;

  /// No description provided for @authPasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters.'**
  String get authPasswordTooShort;

  /// No description provided for @authPasswordWhitespace.
  ///
  /// In en, this message translates to:
  /// **'Password cannot start or end with spaces.'**
  String get authPasswordWhitespace;

  /// No description provided for @authPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get authPasswordMismatch;

  /// No description provided for @errorInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Email or password is incorrect.'**
  String get errorInvalidCredentials;

  /// No description provided for @errorTooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please try again later.'**
  String get errorTooManyAttempts;

  /// No description provided for @errorPasswordPolicy.
  ///
  /// In en, this message translates to:
  /// **'Password does not meet the requirements (min 8 characters).'**
  String get errorPasswordPolicy;

  /// No description provided for @errorCodeInvalid.
  ///
  /// In en, this message translates to:
  /// **'The verification code is wrong or has expired.'**
  String get errorCodeInvalid;

  /// No description provided for @errorNetwork.
  ///
  /// In en, this message translates to:
  /// **'Cannot reach the server. Check your connection and try again.'**
  String get errorNetwork;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
