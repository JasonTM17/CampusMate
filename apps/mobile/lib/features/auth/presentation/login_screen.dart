import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../../app/theme/app_radius.dart';
import '../../../app/theme/app_spacing.dart';
import '../application/auth_controller.dart';
import '../domain/auth_failure.dart';

/// Full-screen email + password sign-in form.
///
/// On success the auth controller transitions to `authenticated`; failures
/// render a localized message near the submit button. New users are sent to
/// [RegistrationScreen] via `/register`.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _submitting = false;
  AuthFailure? _failure;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Validates, calls the controller, and routes into the app on success.
  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _submitting = true;
      _failure = null;
    });
    try {
      await ref
          .read(authControllerProvider.notifier)
          .signIn(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
      if (mounted) context.go('/ai');
    } on AuthFailure catch (failure) {
      if (mounted)
        setState(() {
          _failure = failure;
        });
    } finally {
      if (mounted)
        setState(() {
          _submitting = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.authSignIn)),
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
                    Icon(
                      Icons.smart_toy_outlined,
                      size: 48,
                      color: theme.colorScheme.primary,
                      semanticLabel: l10n.appTitle,
                    ),
                    SizedBox(height: AppSpacing.s),
                    Text(
                      l10n.authLoginTitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.authLoginSubtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    SizedBox(height: AppSpacing.l),
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.authEmailLabel,
                        prefixIcon: const Icon(Icons.alternate_email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      textInputAction: TextInputAction.next,
                      enabled: !_submitting,
                      validator: (value) =>
                          (value == null || !value.contains('@'))
                          ? l10n.authEmailInvalid
                          : null,
                    ),
                    SizedBox(height: AppSpacing.s),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.authPasswordLabel,
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
                      autofillHints: const [AutofillHints.password],
                      textInputAction: TextInputAction.done,
                      enabled: !_submitting,
                      onFieldSubmitted: (_) => _submit(),
                      validator: (value) => (value == null || value.isEmpty)
                          ? l10n.authPasswordEmpty
                          : null,
                    ),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: AppRadius.mRadius,
                        ),
                      ),
                      child: _submitting
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                semanticsLabel: l10n.authSigningIn,
                              ),
                            )
                          : Text(l10n.authSignIn),
                    ),
                    SizedBox(height: AppSpacing.s),
                    TextButton(
                      onPressed: _submitting
                          ? null
                          : () => context.go('/register'),
                      child: Text(l10n.authNoAccountYet),
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
