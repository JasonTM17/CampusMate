import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/auth_redirects.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../core/utils/app_validators.dart';
import '../../../core/widgets/app_error_banner.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/auth_controller.dart';
import '../domain/auth_failure.dart';

/// Three-step password reset flow backed by Serverpod's email identity
/// provider: request a code, verify it, then set a new password.
class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({super.key});

  @override
  ConsumerState<PasswordResetScreen> createState() =>
      _PasswordResetScreenState();
}

class _PasswordResetScreenState extends ConsumerState<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UuidValue? _passwordResetRequestId;
  String? _finishPasswordResetToken;
  AuthFailure? _failure;
  bool _obscurePassword = true;
  bool _submitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool get _onEmailStep => _passwordResetRequestId == null;

  bool get _onCodeStep =>
      _passwordResetRequestId != null && _finishPasswordResetToken == null;

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() {
      _submitting = true;
      _failure = null;
    });

    final repository = ref.read(authRepositoryProvider);
    try {
      if (_onEmailStep) {
        final requestId = await repository.startPasswordReset(
          email: _emailController.text.trim(),
        );
        if (mounted) setState(() => _passwordResetRequestId = requestId);
      } else if (_onCodeStep) {
        final token = await repository.verifyPasswordResetCode(
          passwordResetRequestId: _passwordResetRequestId!,
          verificationCode: _codeController.text.trim(),
        );
        if (mounted) setState(() => _finishPasswordResetToken = token);
      } else {
        await ref
            .read(authControllerProvider.notifier)
            .finishPasswordReset(
              finishPasswordResetToken: _finishPasswordResetToken!,
              newPassword: _passwordController.text,
            );
        if (mounted) {
          final loc = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(loc.authResetPasswordDone)));
          context.go(
            authRouteWithCurrentFrom(GoRouterState.of(context).uri, loginPath),
          );
        }
      }
    } on AuthFailure catch (failure) {
      if (mounted) setState(() => _failure = failure);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  String? _validatePassword(String? value) {
    final loc = AppLocalizations.of(context)!;
    final password = value ?? '';
    if (password.length < 8) return loc.authPasswordTooShort;
    if (password.trim() != password) return loc.authPasswordWhitespace;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(loc.authResetPasswordTitle)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: AppSpacing.lHorizontal,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _onEmailStep
                          ? loc.authResetPasswordEmailStep
                          : _onCodeStep
                          ? loc.authResetPasswordCodeStep
                          : loc.authResetPasswordNewPasswordStep,
                      style: theme.textTheme.headlineSmall,
                    ),
                    SizedBox(height: AppSpacing.s),
                    if (_onEmailStep) ...[
                      Text(
                        loc.authResetPasswordHelp,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: AppSpacing.m),
                      TextFormField(
                        controller: _emailController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: loc.authEmailLabel,
                          prefixIcon: const Icon(Icons.alternate_email),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        autofillHints: const [AutofillHints.email],
                        textInputAction: TextInputAction.done,
                        enabled: !_submitting,
                        validator: (value) => AppValidators.email(
                          value,
                          () => loc.authEmailInvalid,
                        ),
                      ),
                    ],
                    if (_onCodeStep) ...[
                      Text(
                        loc.authRegisterCodeHelp,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      SizedBox(height: AppSpacing.m),
                      TextFormField(
                        controller: _codeController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: loc.authRegisterCodeHint,
                          prefixIcon: const Icon(Icons.password_outlined),
                        ),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textInputAction: TextInputAction.done,
                        enabled: !_submitting,
                        autocorrect: false,
                        validator: (value) =>
                            (value == null || value.trim().isEmpty)
                            ? loc.errorCodeInvalid
                            : null,
                      ),
                    ],
                    if (!_onEmailStep && !_onCodeStep) ...[
                      TextFormField(
                        controller: _passwordController,
                        autofocus: true,
                        decoration: InputDecoration(
                          labelText: loc.authNewPasswordLabel,
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
                            tooltip: loc.authTogglePasswordVisibility,
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
                          labelText: loc.authConfirmPasswordLabel,
                          prefixIcon: const Icon(Icons.lock_outline),
                        ),
                        obscureText: _obscurePassword,
                        enabled: !_submitting,
                        onFieldSubmitted: (_) => _submit(),
                        validator: (value) => value != _passwordController.text
                            ? loc.authPasswordMismatch
                            : null,
                      ),
                    ],
                    SizedBox(height: AppSpacing.s),
                    if (_failure != null) ...[
                      AppErrorBanner(message: _messageFor(context, _failure!)),
                      SizedBox(height: AppSpacing.m),
                    ],
                    FilledButton(
                      onPressed: _submitting ? null : _submit,
                      child: _submitting
                          ? SizedBox.square(
                              dimension: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                semanticsLabel: loc.authSubmitting,
                              ),
                            )
                          : Text(
                              _onEmailStep
                                  ? loc.authSendCode
                                  : _onCodeStep
                                  ? loc.authVerifyCode
                                  : loc.authResetPasswordFinish,
                            ),
                    ),
                    SizedBox(height: AppSpacing.s),
                    if (_onCodeStep)
                      TextButton(
                        onPressed: _submitting
                            ? null
                            : () => setState(() {
                                _passwordResetRequestId = null;
                                _codeController.clear();
                              }),
                        child: Text(loc.authUseDifferentEmail),
                      ),
                    TextButton(
                      onPressed: _submitting
                          ? null
                          : () => context.go(
                              authRouteWithCurrentFrom(
                                GoRouterState.of(context).uri,
                                loginPath,
                              ),
                            ),
                      child: Text(loc.authBackToLogin),
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

  static String _messageFor(BuildContext context, AuthFailure failure) {
    final loc = AppLocalizations.of(context)!;
    return switch (failure) {
      InvalidCredentialsFailure() => loc.errorInvalidCredentials,
      TooManyAttemptsFailure() => loc.errorTooManyAttempts,
      PasswordPolicyFailure() => loc.errorPasswordPolicy,
      CodeInvalidOrExpiredFailure() => loc.errorCodeInvalid,
      NetworkFailure() => loc.errorNetwork,
      UnknownAuthFailure() => loc.errorGeneric,
    };
  }
}
