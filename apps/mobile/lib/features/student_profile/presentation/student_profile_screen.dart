import 'package:campusmate_client/campusmate_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_spacing.dart';
import '../../../app/theme/theme_mode_controller.dart';
import '../../../core/widgets/app_empty_state.dart';
import '../../../features/auth/application/auth_controller.dart';
import '../../../features/auth/domain/auth_user.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/student_profile_controller.dart';

class StudentProfileScreen extends ConsumerStatefulWidget {
  const StudentProfileScreen({super.key});

  @override
  ConsumerState<StudentProfileScreen> createState() =>
      _StudentProfileScreenState();
}

class _StudentProfileScreenState extends ConsumerState<StudentProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _classNameController = TextEditingController();
  bool _formHydrated = false;
  bool _saving = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _classNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final profileState = ref.watch(studentProfileControllerProvider);
    final authUser = ref.watch(authControllerProvider).user;

    return Scaffold(
      appBar: AppBar(title: Text(loc.profileTitle)),
      body: profileState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => AppEmptyState(
          icon: Icons.error_outline,
          title: loc.profileLoadError,
          message: loc.emptyGeneric,
          actionLabel: loc.retry,
          onAction: () => ref.invalidate(studentProfileControllerProvider),
        ),
        data: (profile) {
          _hydrateForm(profile);
          return _ProfileForm(
            profile: profile,
            email: authUser?.email,
            fullNameController: _fullNameController,
            classNameController: _classNameController,
            formKey: _formKey,
            loc: loc,
            isSaving: _saving,
            canAccessPrivilegedArea:
                authUser != null && canAccessPrivilegedArea(authUser.role),
            onSave: _save,
            onOpenPrivilegedArea: () => context.push('/admin'),
            onSignOut: _signOut,
          );
        },
      ),
    );
  }

  void _hydrateForm(StudentProfile profile) {
    if (_formHydrated) return;
    _fullNameController.text = profile.fullName ?? '';
    _classNameController.text = profile.className ?? '';
    _formHydrated = true;
  }

  Future<void> _save() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    setState(() => _saving = true);
    final loc = AppLocalizations.of(context)!;
    String message;
    try {
      await ref
          .read(studentProfileControllerProvider.notifier)
          .updateMyProfile(
            fullName: _fullNameController.text,
            className: _classNameController.text,
          );
      message = loc.profileSaved;
    } on Exception {
      message = loc.profileSaveError;
    } finally {
      if (mounted) setState(() => _saving = false);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signOut() async {
    await ref.read(authControllerProvider.notifier).signOut();
    if (mounted) context.go('/login');
  }
}

class _ProfileForm extends ConsumerWidget {
  const _ProfileForm({
    required this.profile,
    required this.email,
    required this.fullNameController,
    required this.classNameController,
    required this.formKey,
    required this.loc,
    required this.isSaving,
    required this.canAccessPrivilegedArea,
    required this.onSave,
    required this.onOpenPrivilegedArea,
    required this.onSignOut,
  });

  final StudentProfile profile;
  final String? email;
  final TextEditingController fullNameController;
  final TextEditingController classNameController;
  final GlobalKey<FormState> formKey;
  final AppLocalizations loc;
  final bool isSaving;
  final bool canAccessPrivilegedArea;
  final VoidCallback onSave;
  final VoidCallback onOpenPrivilegedArea;
  final VoidCallback onSignOut;

  /// Mirrors the server-side `_normalizeRequired` rules so a rejectable
  /// input never reaches the network: non-empty and at most 120 characters.
  String? _validateField(String? value, String requiredMessage) {
    final trimmed = value?.trim() ?? '';
    if (trimmed.isEmpty) return requiredMessage;
    if (trimmed.length > 120) return loc.profileFieldTooLong;
    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final displayName = profile.fullName?.isNotEmpty == true
        ? profile.fullName!
        : loc.profileNotSet;
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.cardPadding,
          AppSpacing.m,
          AppSpacing.cardPadding,
          AppSpacing.l,
        ),
        children: [
          // Identity header: avatar initial + name/email so the screen reads
          // as a profile instead of a bare form.
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: theme.colorScheme.primaryContainer,
                child: Text(
                  displayName.characters.first.toUpperCase(),
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
              ),
              SizedBox(width: AppSpacing.m),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(displayName, style: theme.textTheme.titleMedium),
                    Text(
                      email ?? loc.profileNotSet,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppSpacing.sectionGap),
          TextFormField(
            controller: fullNameController,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: loc.profileFullName),
            enabled: !isSaving,
            validator: (value) =>
                _validateField(value, loc.profileFullNameRequired),
          ),
          SizedBox(height: AppSpacing.itemGap),
          TextFormField(
            controller: classNameController,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: loc.profileClassName),
            enabled: !isSaving,
            validator: (value) =>
                _validateField(value, loc.profileClassNameRequired),
          ),
          SizedBox(height: AppSpacing.itemGap),
          FilledButton.icon(
            onPressed: isSaving ? null : onSave,
            icon: isSaving
                ? const SizedBox.square(
                    dimension: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(loc.profileSave),
          ),
          SizedBox(height: AppSpacing.sectionGap),
          const Divider(),
          _ProfileDetail(
            label: loc.profileStudentCode,
            value: profile.studentCode,
            loc: loc,
          ),
          _ProfileDetail(
            label: loc.profileFaculty,
            value: profile.faculty,
            loc: loc,
          ),
          _ProfileDetail(
            label: loc.profileMajor,
            value: profile.major,
            loc: loc,
          ),
          _ProfileDetail(
            label: loc.profileGpa,
            value: profile.gpa?.toStringAsFixed(2),
            loc: loc,
          ),
          _ProfileDetail(
            label: loc.profileCredits,
            value: profile.credits?.toString(),
            loc: loc,
          ),
          _ProfileDetail(
            label: loc.profileConductScore,
            value: profile.conductScore?.toStringAsFixed(2),
            loc: loc,
          ),
          _ProfileDetail(label: loc.profileRole, value: profile.role, loc: loc),
          const Divider(),
          ListTile(
            key: const Key('ai-settings-tile'),
            contentPadding: EdgeInsets.zero,
            leading: const Icon(
              Icons.psychology_outlined,
              color: AppColors.primary,
            ),
            title: const Text('Cài đặt & Bộ nhớ AI'),
            subtitle: const Text(
              'Tùy chỉnh phong cách giải thích và quản lý bộ nhớ',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push('/ai/settings'),
          ),
          const Divider(),
          const SizedBox(height: AppSpacing.s),
          Text(
            'Giao diện ứng dụng',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          SegmentedButton<ThemeMode>(
            key: const Key('theme-mode-segmented-button'),
            segments: const [
              ButtonSegment(
                value: ThemeMode.system,
                icon: Icon(Icons.brightness_auto_outlined),
                label: Text('Hệ thống'),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: Icon(Icons.light_mode_outlined),
                label: Text('Sáng'),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: Icon(Icons.dark_mode_outlined),
                label: Text('Tối'),
              ),
            ],
            selected: {ref.watch(appThemeModeProvider)},
            onSelectionChanged: (selected) {
              ref
                  .read(appThemeModeProvider.notifier)
                  .setThemeMode(selected.first);
            },
          ),
          const SizedBox(height: AppSpacing.m),
          Text(
            'Ngôn ngữ / Language',
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.s),
          SegmentedButton<String>(
            key: const Key('language-segmented-button'),
            segments: const [
              ButtonSegment(
                value: 'vi',
                icon: Icon(Icons.language),
                label: Text('Tiếng Việt'),
              ),
              ButtonSegment(
                value: 'en',
                icon: Icon(Icons.translate),
                label: Text('English'),
              ),
            ],
            selected: {ref.watch(appLocaleProvider).languageCode},
            onSelectionChanged: (selected) {
              ref
                  .read(appLocaleProvider.notifier)
                  .setLocale(Locale(selected.first));
            },
          ),
          SizedBox(height: AppSpacing.sectionGap),
          if (canAccessPrivilegedArea)
            OutlinedButton.icon(
              onPressed: onOpenPrivilegedArea,
              icon: const Icon(Icons.admin_panel_settings_outlined),
              label: Text(loc.profilePrivilegedArea),
            ),
          OutlinedButton.icon(
            onPressed: onSignOut,
            icon: const Icon(Icons.logout),
            label: Text(loc.profileSignOut),
          ),
        ],
      ),
    );
  }
}

class _ProfileDetail extends StatelessWidget {
  const _ProfileDetail({
    required this.label,
    required this.value,
    required this.loc,
  });

  final String label;
  final String? value;
  final AppLocalizations loc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Text(value?.isNotEmpty == true ? value! : loc.profileNotSet),
    );
  }
}
