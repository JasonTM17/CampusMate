import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_spacing.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/auth_controller.dart';
import '../domain/auth_failure.dart';

/// Three-step real registration flow against the email identity provider:
///
/// 1. **email** — `startRegistration` makes the server deliver a code.
/// 2. **code** — `verifyRegistrationCode` exchanges the code for a
///    registration token.
/// 3. **password** — `finishRegistration` creates the user and signs in.
///
/// In dev the verification code is printed to the server console (no mail
/// service is configured); production sends it by email.
class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _submitting = false;
  AuthFailure? _failure;

  UuidValue? _accountRequestId;
  String? _registrationToken;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _onEmailStep => _accountRequestId == null;
  bool get _onCodeStep =>
      _accountRequestId != null && _registrationToken == null;

  /// Runs the current step's server call and advances on success.
  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _submitting = true;
      _failure = null;
    });
    final repository = ref.read(authRepositoryProvider);
    try {
      if (_onEmailStep) {
        final requestId = await repository.startRegistration(
          email: _emailController.text.trim(),
        );
        if (mounted) {
          setState(() {
            _accountRequestId = requestId;
          });
        }
        return;
      } else if (_onCodeStep) {
        final token = await repository.verifyRegistrationCode(
          accountRequestId: _accountRequestId!,
          verificationCode: _codeController.text.trim(),
        );
        if (mounted) {
          setState(() {
            _registrationToken = token;
          });
        }
        return;
      }

      await ref
          .read(authControllerProvider.notifier)
          .completeRegistration(
            email: _emailController.text.trim(),
            registrationToken: _registrationToken!,
            password: _passwordController.text,
          );
      if (mounted) {
        context.go('/ai');
      }
    } on AuthFailure catch (failure) {
      if (mounted) {
        setState(() {
          _failure = failure;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  /// Password rule shared with the server default policy: at least 8
  /// characters and no leading/trailing whitespace.
  String? _validatePassword(String? value) {
    final l10n = AppLocalizations.of(context)!;
    final password = value ?? '';
    if (password.length < 8) return l10n.authPasswordTooShort;
    if (password.trim() != password) return l10n.authPasswordWhitespace;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.authCreateAccount)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.lHorizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _onEmailStep
                          ? l10n.authRegisterEmailStep
                          : _onCodeStep
                          ? l10n.authRegisterCodeStep
                          : l10n.authRegisterPasswordStep,
                      style: theme.textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppSpacing.s),
                    if (_onEmailStep) ...[
                      Text(
                        l10n.authRegisterEmailHelp,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: AppSpacing.m),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: l10n.authEmailLabel,
                          prefixIcon: const Icon(Icons.alternate_email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.done,
                        enabled: !_submitting,
                        validator: (value) =>
                            (value == null || !value.contains('@'))
                            ? l10n.authEmailInvalid
                            : null,
                      ),
                    ],
                    if (_onCodeStep) ...[
                      Text(
                        l10n.authRegisterCodeHelp,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: AppSpacing.m),
                      TextFormField(
                        controller: _codeController,
                        decoration: InputDecoration(
                          labelText: l10n.authRegisterCodeHint,
                          prefixIcon: const Icon(Icons.password_outlined),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        enabled: !_submitting,
                        autocorrect: false,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? l10n.errorCodeInvalid
                            : null,
                      ),
                    ],
                    if (!_onEmailStep && !_onCodeStep) ...[
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: l10n.authNewPasswordLabel,
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              _obscurePassword = !_obscurePassword;
                            }),
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                            ),
                            tooltip: l10n.authTogglePasswordVisibility,
                          ),
                        ),
                        obscureText: _obscurePassword,
                        autofillHints: const [AutofillHints.newPassword],
                        textInputAction: TextInputAction.next,
                        enabled: !_submitting,
                        validator: _validatePassword,
                      ),
                      SizedBox(height: AppSpacing.s),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: InputDecoration(
                          labelText: l10n.authConfirmPasswordLabel,
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        enabled: !_submitting,
                        onFieldSubmitted: (_) => _submit(),
                        validator: (value) =>
                            (value != _passwordController.text)
                            ? l10n.authPasswordMismatch
                            : null,
                      ),
                    ],
                    SizedBox(height: AppSpacing.s),
                    if (_failure != null)
                      Text(
                        _messageFor(context, _failure!),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    SizedBox(height: AppSpacing.m),
                    FilledButton(
                      onPressed: _submitting ? null : _submit,
                      style: FilledButton.styleFrom(
                        minimumSize: const Size.fromHeight(48),
                      ),
                      child: _submitting
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                semanticsLabel: l10n.authSubmitting,
                              ),
                            )
                          : Text(
                              _onEmailStep
                                  ? l10n.authSendCode
                                  : _onCodeStep
                                  ? l10n.authVerifyCode
                                  : l10n.authFinishRegistration,
                            ),
                    ),
                    SizedBox(height: AppSpacing.s),
                    TextButton(
                      onPressed: _submitting
                          ? null
                          : () => context.go('/login'),
                      child: Text(l10n.authAlreadyHaveAccount),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Maps a typed [AuthFailure] onto its localized user-facing message.
  static String _messageFor(BuildContext context, AuthFailure failure) {
    final l10n = AppLocalizations.of(context)!;
    return switch (failure) {
      InvalidCredentialsFailure() => l10n.errorInvalidCredentials,
      TooManyAttemptsFailure() => l10n.errorTooManyAttempts,
      PasswordPolicyFailure() => l10n.errorPasswordPolicy,
      CodeInvalidOrExpiredFailure() => l10n.errorCodeInvalid,
      NetworkFailure() => l10n.errorNetwork,
      UnknownAuthFailure() => l10n.errorGeneric,
    };
  }
}
