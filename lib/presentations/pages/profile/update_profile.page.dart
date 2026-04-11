import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/update_profile_form/update_profile_form_cubit.dart';
import 'package:base_app/presentations/bloc/user/update_profile_form/update_profile_form_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/profile/item_address_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_constant_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_date_of_birth_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_gender_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_input_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_profile.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_save_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final updateProfilePageRoute = GoRoute(
    path: Pages.updateProfilePage,
    builder: (context, GoRouterState state) => const UpdateProfilePage());

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({super.key});

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = dI<UserBloc>().state.user;
      dI<UpdateProfileFormCubit>().loadFromUser(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          l10n.editPersonalInformation,
          style: TextStyle(
            fontSize: SpacingUnit.x4_5,
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          return BlocBuilder<UpdateProfileFormCubit, UpdateProfileFormState>(
            builder: (context, formState) {
              final formCubit = context.read<UpdateProfileFormCubit>();
              return SingleChildScrollView(
                child: Column(
                  children: [
                    // ── Avatar section ──
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        vertical: SpacingUnit.x4,
                      ),
                      child: ItemProfile(
                        isCheck: true,
                        onChange: formCubit.avatarChanged,
                      ),
                    ),
                    Divider(
                        height: 1,
                        color: colors.text.withValues(alpha: 0.06)),

                    // ── Form sections ──
                    Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Section: Account info (read-only)
                          _SectionLabel(
                              label: l10n.account,
                              theme: theme,
                              colors: colors),
                          const SizedBox(height: SpacingUnit.x2),
                          _FormCard(
                            colors: colors,
                            child: Column(
                              children: [
                                ItemUpdateProfileConstant(
                                  checkOpacity: true,
                                  title: l10n.employeeCode,
                                  content: userState.user.code,
                                ),
                                ItemUpdateProfileConstant(
                                  checkOpacity: true,
                                  title: l10n.companyEmail,
                                  content: userState.user.companyEmail,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SpacingUnit.x5),

                          // Section: Personal info (editable)
                          _SectionLabel(
                              label: l10n.editPersonalInformation,
                              theme: theme,
                              colors: colors),
                          const SizedBox(height: SpacingUnit.x2),
                          _FormCard(
                            colors: colors,
                            child: Column(
                              children: [
                                ItemInputUpdateProfile(
                                  requiredValidate: true,
                                  error: formState.firstNameMissing
                                      ? l10n.cannotBeLeftBlank
                                      : '',
                                  title: l10n.firstName,
                                  content: formState.firstName,
                                  onChange: formCubit.firstNameChanged,
                                ),
                                ItemInputUpdateProfile(
                                  requiredValidate: true,
                                  error: formState.lastNameMissing
                                      ? l10n.cannotBeLeftBlank
                                      : '',
                                  title: l10n.lastName,
                                  content: formState.lastName,
                                  onChange: formCubit.lastNameChanged,
                                ),
                                ItemDateOfBirthUpdateProfile(
                                  title: l10n.dateOfBirth,
                                  dateOfBirth: formState.dateOfBirth,
                                  onChangeDateOfBirth:
                                      formCubit.dateOfBirthChanged,
                                ),
                                ItemGenderUpdateProfile(
                                  onChangeGender: formCubit.genderChanged,
                                  gender: formState.gender,
                                ),
                                ItemInputUpdateProfile(
                                  requiredValidate: true,
                                  title: l10n.phoneNumber,
                                  content: formState.phoneNumber,
                                  onChange: formCubit.phoneNumberChanged,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SpacingUnit.x5),

                          // Section: Address
                          _SectionLabel(
                              label: l10n.address,
                              theme: theme,
                              colors: colors),
                          const SizedBox(height: SpacingUnit.x2),
                          _FormCard(
                            colors: colors,
                            child: Column(
                              children: [
                                ItemAddressUpdateProfile(
                                  province: formState.province ??
                                      const Address(),
                                  district: formState.district ??
                                      const Address(),
                                  ward:
                                      formState.ward ?? const Address(),
                                  onChangeProvince:
                                      formCubit.provinceChanged,
                                  onChangeDistrict:
                                      formCubit.districtChanged,
                                  onChangeWard: formCubit.wardChanged,
                                ),
                                ItemInputUpdateProfile(
                                  title: l10n.address,
                                  content: formState.address,
                                  onChange: formCubit.addressChanged,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: SpacingUnit.x6),

                          // ── Save button ──
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () => _onSubmitPressed(
                                context: context,
                                user: userState.user,
                                formCubit: formCubit,
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF014282),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      SpacingUnit.x3),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                l10n.saveUpdateInfo,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: SpacingUnit.x8),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onSubmitPressed({
    required BuildContext context,
    required User user,
    required UpdateProfileFormCubit formCubit,
  }) {
    final l10n = AppLocalizations.of(context)!;
    final isValid = formCubit.validate();
    if (!isValid) return;

    if (!_isPhoneNumberValid(formCubit.state.phoneNumber)) return;

    dialogCheckSave(
      context: context,
      title: l10n.doYouWantToUpdateProfile,
      callback: () => _submitUpdate(user: user, formCubit: formCubit),
    );
  }

  bool _isPhoneNumberValid(String phoneNumber) {
    if (phoneNumber.isEmpty) return false;
    return RegExp(checkPhoneNumberRegexExp).hasMatch(phoneNumber) ||
        phoneNumber.isNotEmpty;
  }

  Future<void> _submitUpdate({
    required User user,
    required UpdateProfileFormCubit formCubit,
  }) async {
    final formState = formCubit.state;
    final navContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(navContext);

    formCubit.markSubmitting();
    dialogIndicator(context: navContext);

    final completer = Completer<bool>();
    dI<UserBloc>().add(
      UpdateProfileEvent(
        updateProfileRequest: _buildRequest(user, formState),
        file: formState.avatarFile,
        completer: completer,
      ),
    );

    final success = await completer.future;
    if (!navContext.mounted) return;

    if (success) {
      formCubit.markSubmitSuccess();
      dI<AppNavigation>().pop(navContext);
      updateProfileSuccess();
    } else {
      formCubit.markSubmitFailed('');
      updateProfileFail(errorDialog: '');
    }
  }

  UpdateProfileRequest _buildRequest(User user, UpdateProfileFormState form) {
    String? toIdOrNull(String? id) =>
        (id != null && id.isNotEmpty) ? id : null;

    return UpdateProfileRequest(
      id: user.id,
      firstName: form.firstName,
      lastName: form.lastName,
      dayOfBirth: form.dateOfBirth,
      gender: form.gender.name,
      phoneNumber: form.phoneNumber,
      residentProvince: form.province?.name,
      residentProvinceId: toIdOrNull(form.province?.id),
      residentDistrict: form.district?.name,
      residentDistrictId: toIdOrNull(form.district?.id),
      residentWard: form.ward?.name,
      residentWardId: toIdOrNull(form.ward?.id),
      residentAddress:
          form.address.isEmpty ? user.residentAddress : form.address,
      avatarPath: user.avatarPath.isEmpty ? null : user.avatarPath,
      vehicleType: form.vehicleType?.name ?? user.vehicleType.name,
    );
  }
}

// ---------------------------------------------------------------------------
// Section label
// ---------------------------------------------------------------------------

class _SectionLabel extends StatelessWidget {
  final String label;
  final ThemeData theme;
  final dynamic colors;

  const _SectionLabel(
      {required this.label, required this.theme, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: colors.text,
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Form card wrapper
// ---------------------------------------------------------------------------

class _FormCard extends StatelessWidget {
  final Widget child;
  final dynamic colors;

  const _FormCard({required this.child, required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: SpacingUnit.x4,
        vertical: SpacingUnit.x2,
      ),
      decoration: BoxDecoration(
        color: colors.text.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(SpacingUnit.x3),
        border:
            Border.all(color: colors.text.withValues(alpha: 0.06)),
      ),
      child: child,
    );
  }
}
