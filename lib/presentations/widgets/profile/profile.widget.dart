import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/auth/auth_event.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_roles/user_by_roles_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state.status == UserStatus.success) {
            dI<UserBloc>().add(const GetUserInfo());
          }
        },
        listenWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          final user = state.user;
          return SingleChildScrollView(
            child: Column(
              children: [
                // ── Header with avatar + name ──
                _ProfileHeader(user: user, l10n: l10n, colors: colors, theme: theme),
                const SizedBox(height: SpacingUnit.x4),

                // ── Personal info section ──
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionTitle(title: l10n.editPersonalInformation, theme: theme, colors: colors),
                      const SizedBox(height: SpacingUnit.x3),
                      _InfoCard(
                        children: [
                          _InfoRow(
                            icon: Icons.cake_outlined,
                            iconColor: Colors.pink,
                            label: l10n.dateOfBirth,
                            value: formatDMY(user.dayOfBirth.toString()),
                          ),
                          _InfoRow(
                            icon: Icons.wc_outlined,
                            iconColor: Colors.indigo,
                            label: l10n.gender,
                            value: user.gender.configGenderName,
                          ),
                          _InfoRow(
                            icon: Icons.phone_outlined,
                            iconColor: Colors.green,
                            label: l10n.phoneNumber,
                            value: user.phoneNumber,
                          ),
                          _InfoRow(
                            icon: Icons.email_outlined,
                            iconColor: Colors.blue,
                            label: l10n.companyEmail,
                            value: user.companyEmail,
                            isLast: true,
                          ),
                        ],
                      ),
                      const SizedBox(height: SpacingUnit.x4),

                      // ── Work info section ──
                      _SectionTitle(title: l10n.department, theme: theme, colors: colors),
                      const SizedBox(height: SpacingUnit.x3),
                      _InfoCard(
                        children: [
                          for (int i = 0; i < user.userDepartmentPositions.length; i++)
                            _InfoRow(
                              icon: Icons.business_outlined,
                              iconColor: const Color(0xFF014282),
                              label: user.userDepartmentPositions[i].department?.name ?? '',
                              value: user.userDepartmentPositions[i].position?.name ?? '',
                              isLast: i == user.userDepartmentPositions.length - 1,
                            ),
                          if (user.userDepartmentPositions.isEmpty)
                            _InfoRow(
                              icon: Icons.business_outlined,
                              iconColor: const Color(0xFF014282),
                              label: l10n.department,
                              value: '--',
                              isLast: true,
                            ),
                        ],
                      ),
                      const SizedBox(height: SpacingUnit.x4),

                      // ── Address section ──
                      if (_buildAddress(user).isNotEmpty) ...[
                        _SectionTitle(title: l10n.address, theme: theme, colors: colors),
                        const SizedBox(height: SpacingUnit.x3),
                        _InfoCard(
                          children: [
                            _InfoRow(
                              icon: Icons.location_on_outlined,
                              iconColor: Colors.red,
                              label: l10n.address,
                              value: _buildAddress(user),
                              isLast: true,
                            ),
                          ],
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                      ],

                      // ── Actions section ──
                      _SectionTitle(title: l10n.account, theme: theme, colors: colors),
                      const SizedBox(height: SpacingUnit.x3),
                      _ActionCard(
                        children: [
                          _ActionRow(
                            icon: Icons.edit_outlined,
                            iconColor: const Color(0xFF014282),
                            label: l10n.editPersonalInformation,
                            onTap: () => dI<AppNavigation>().push(context, page: Pages.updateProfilePage),
                          ),
                          _ActionRow(
                            icon: Icons.fingerprint_rounded,
                            iconColor: Colors.teal,
                            label: l10n.settingBiometric,
                            onTap: () => dI<AppNavigation>().push(context, page: Pages.biometricRegister),
                          ),
                          _ActionRow(
                            icon: Icons.lock_outline_rounded,
                            iconColor: Colors.orange,
                            label: l10n.changePassword,
                            onTap: () => dI<AppNavigation>().push(context, page: Pages.changePasswordPage),
                          ),
                          BlocBuilder<LanguageCubit, LanguageState>(
                            builder: (context, langState) {
                              return _ActionRow(
                                icon: Icons.language_rounded,
                                iconColor: Colors.purple,
                                label: langState.languageCode == LanguageEnum.en
                                    ? 'Language: English'
                                    : 'Ngôn ngữ: Tiếng Việt',
                                onTap: () {
                                  if (langState.languageCode == LanguageEnum.en) {
                                    dI<LanguageCubit>().changeLocale(LanguageEnum.vi);
                                  } else {
                                    dI<LanguageCubit>().changeLocale(LanguageEnum.en);
                                  }
                                },
                              );
                            },
                          ),
                          _ActionRow(
                            icon: Icons.logout_rounded,
                            iconColor: Colors.red,
                            label: l10n.logout,
                            isDestructive: true,
                            isLast: true,
                            onTap: () {
                              dI<AuthBloc>().add(const LogoutEvent());
                              dI<UserBloc>().add(const ResetUserEvent());
                              dI<UserByRolesBloc>().add(const ResetUsersEvent());
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: SpacingUnit.x8),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _buildAddress(User user) {
    final parts = <String>[];
    if (user.residentProvince.isNotEmpty) parts.add(user.residentProvince);
    if (user.residentDistrict.isNotEmpty) parts.add(user.residentDistrict);
    if (user.residentWard.isNotEmpty) parts.add(user.residentWard);
    if (user.residentAddress.isNotEmpty) parts.add(user.residentAddress);
    return parts.join(', ');
  }
}

// ---------------------------------------------------------------------------
// Profile Header — avatar + name + code
// ---------------------------------------------------------------------------

class _ProfileHeader extends StatelessWidget {
  final User user;
  final AppLocalizations l10n;
  final dynamic colors;
  final ThemeData theme;

  const _ProfileHeader({
    required this.user,
    required this.l10n,
    required this.colors,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFf38120), Color(0xFFe06b10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            SpacingUnit.x4,
            SpacingUnit.x4,
            SpacingUnit.x4,
            SpacingUnit.x6,
          ),
          child: Column(
            children: [
              // Avatar
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: user.avatarPath.isNotEmpty
                      ? Image.network(
                          user.avatarPath,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => Image.asset(
                            Assets.images.error.imageError.path,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          Assets.images.error.imageError.path,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: SpacingUnit.x3),
              // Full name
              Text(
                user.fullName,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              // Employee code badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF014282),
                  borderRadius: BorderRadius.circular(SpacingUnit.x5),
                ),
                child: Text(
                  '${l10n.employeeCode}: ${user.code}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section Title
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String title;
  final ThemeData theme;
  final dynamic colors;

  const _SectionTitle({required this.title, required this.theme, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: colors.text,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Info Card — rounded container
// ---------------------------------------------------------------------------

class _InfoCard extends StatelessWidget {
  final List<Widget> children;
  const _InfoCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.text.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(SpacingUnit.x3),
        border: Border.all(color: colors.text.withValues(alpha: 0.06)),
      ),
      child: Column(children: children),
    );
  }
}

// ---------------------------------------------------------------------------
// Info Row — icon + label + value
// ---------------------------------------------------------------------------

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isLast;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SpacingUnit.x4,
            vertical: SpacingUnit.x3,
          ),
          child: Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: SpacingUnit.x3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.text.withValues(alpha: 0.5),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value.isNotEmpty ? value : '--',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.text,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: SpacingUnit.x4 + 36 + SpacingUnit.x3,
            color: colors.text.withValues(alpha: 0.06),
          ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Action Card — for menu items
// ---------------------------------------------------------------------------

class _ActionCard extends StatelessWidget {
  final List<Widget> children;
  const _ActionCard({required this.children});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Container(
      decoration: BoxDecoration(
        color: colors.text.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(SpacingUnit.x3),
        border: Border.all(color: colors.text.withValues(alpha: 0.06)),
      ),
      child: Column(children: children),
    );
  }
}

// ---------------------------------------------------------------------------
// Action Row — tappable menu item
// ---------------------------------------------------------------------------

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;
  final bool isLast;

  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: isLast
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(SpacingUnit.x3),
                  bottomRight: Radius.circular(SpacingUnit.x3),
                )
              : null,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x4,
              vertical: SpacingUnit.x3,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: SpacingUnit.x3),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                      color: isDestructive ? Colors.red : colors.text,
                      fontSize: 14,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colors.text.withValues(alpha: 0.3),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
        if (!isLast)
          Divider(
            height: 1,
            indent: SpacingUnit.x4 + 36 + SpacingUnit.x3,
            color: colors.text.withValues(alpha: 0.06),
          ),
      ],
    );
  }
}
