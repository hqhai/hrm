// ignore_for_file: use_build_context_synchronously

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/data/models/user/profile/update_user_department_position_request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/profile/item_address_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_gender_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_date_of_birth_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_input_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_constant_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_department_and_position_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_text_title_profile.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final updateProfilePageRoute = GoRoute(
    path: Pages.updateProfilePage,
    builder: (context, GoRouterState state) => const UpdateProfilePage());

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    super.key,
  });

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String code = '',
      email = '',
      dateOfBirth = '',
      phoneNumber = '',
      province = '',
      district = '',
      ward = '',
      address = '',
      firstName = '',
      lastName = '';
  GenderEnum gender = GenderEnum.male;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ItemProfile(),
                  const SizedBox(
                    height: SpacingUnit.x9_5,
                  ),
                  Container(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x2),
                      color: CustomsColor.colorBackground,
                      border: Border.all(
                        color: colors.text,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemUpdateProfileConstant(
                            title: appLocalizations.employeeCode, content: state.user.code ?? ''),
                        ItemUpdateProfileConstant(
                            title: appLocalizations.email, content: state.user.email ?? ''),
                        ItemDateOfBirthUpdateProfile(
                          dateOfBirth: formatDMY(
                            state.user.dayOfBirth ?? '',
                          ),
                          onChangeDateOfBirth: (value) => dateOfBirth = formatYMD(value),
                        ),
                        ItemInputUpdateProfile(
                          title: appLocalizations.firstName,
                          content: state.user.firstName ?? "",
                          onChange: (value) => _setFirstName(value),
                        ),
                        ItemInputUpdateProfile(
                          title: appLocalizations.lastName,
                          content: state.user.lastName ?? "",
                          onChange: (value) => _setLastName(value),
                        ),
                        ItemInputUpdateProfile(
                          title: appLocalizations.phoneNumber,
                          content: state.user.phoneNumber ?? "",
                          onChange: (value) => _setPhoneNumber(value),
                        ),
                        ItemGenderUpdateProfile(
                            onChangeGender: (value) => _setGender(value),
                            gender: state.user.gender ?? ""),
                        ItemAddressUpdateProfile(
                            onChangeProvince: (value) => _setProvince(value),
                            onChangeDistrict: (value) => _setDistrict(value),
                            onChangeWard: (value) => _setWard(value)),
                        ItemInputUpdateProfile(
                          title: appLocalizations.address,
                          content: state.user.residentAddress ?? "",
                          onChange: (value) => _setAddress(value),
                        ),
                        ItemTitleProfile(
                          check: false,
                          title1: appLocalizations.department,
                          title2: appLocalizations.position,
                        ),
                        ItemDepartmentAndPositionProfile(
                          check: false,
                          departmentNames: state.user.userDepartmentPositions.isNotEmpty
                              ? state.user.userDepartmentPositions
                                  .map((e) => e.department?.name ?? "")
                                  .toList()
                              : [],
                          positionNames: state.user.userDepartmentPositions.isNotEmpty
                              ? state.user.userDepartmentPositions
                                  .map((e) => e.position?.name ?? "")
                                  .toList()
                              : [],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: colors.blue),
                    onPressed: () => _updateProfile(context, state),
                    child: Text(appLocalizations.update,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x5,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _updateProfile(BuildContext context, UserState state) {
    final List<UpdateUserDepartmentPositionRequest> updateUserDepartmentPositionRequests = [];
    for (int i = 0; i <= state.user.userDepartmentPositions.length; i++) {
      UpdateUserDepartmentPositionRequest updateUserDepartmentPositionRequest =
          UpdateUserDepartmentPositionRequest(
              id: state.user.userDepartmentPositions[i].id,
              positionId: state.user.userDepartmentPositions[i].positionId,
              departmentId: state.user.userDepartmentPositions[i].departmentId);
      updateUserDepartmentPositionRequests.add(updateUserDepartmentPositionRequest);
    }

    final UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
      id: state.user.id,
      firstName: firstName,
      lastName: lastName,
      dayOfBirth: dateOfBirth,
      userDepartmentPositions: updateUserDepartmentPositionRequests,
      gender: gender.nameEn,
      phoneNumber: state.user.phoneNumber ?? "",
      email: state.user.email ?? "",
      tax: state.user.tax ?? "",
      families: state.user.families ?? [],
      ciNumber: state.user.ciNumber ?? "",
      ciIssuePlace: state.user.ciIssuePlace ?? "",
      ciIssueDate: state.user.ciIssueDate ?? "",
      ciExpiryDate: state.user.ciExpiryDate ?? "",
      passPortIssuePlace: state.user.passPortIssuePlace ?? "",
      passPortIssueDate: state.user.passPortIssueDate ?? "",
      passPortExpiryDate: state.user.passPortExpiryDate ?? "",
      passPortNumber: state.user.passPortNumber ?? "",
      residentProvince: province,
      residentDistrict: district,
      residentWard: ward,
      residentAddress: address,
      originAddress: state.user.originAddress ?? "",
      originWard: state.user.originWard ?? "",
      originDistrict: state.user.originDistrict ?? "",
      originProvince: state.user.originProvince ?? "",
      maritalStatus: state.user.maritalStatus ?? "",
      ethnicity: state.user.ethnicity ?? "",
      religion: state.user.religion ?? "",
      bankName: state.user.bankName ?? "",
      accountHolderName: state.user.accountHolderName ?? "",
      accountNumber: state.user.accountNumber ?? "",
      companyEmail: state.user.companyEmail ?? "",
      educationLevel: null,
      education: state.user.education ?? "",
      specializes: state.user.specializes ?? "",
      graduationType: state.user.graduationType ?? "",
      graduationYear: state.user.graduationYear ?? "",
      profileStatus: state.user.profileStatus ?? true,
      probationDay: state.user.probationDay ?? "",
      officialDay: state.user.officialDay ?? "",
      statusUser: state.user.statusUser ?? "",
      typeOfPersonnel: state.user.typeOfPersonnel ?? "",
      description: state.user.description ?? "",
      fullName: state.user.fullName ?? "",
      avatarPath: state.user.avatarPath ?? "",
      code: state.user.code ?? "",
      userName: state.user.userName ?? "",
      residentLocationId: state.user.residentLocationId ?? "",
      createdFullName: state.user.createdFullName ?? "",
      createdUserId: state.user.createdUserId,
      createdDate: state.user.createdDate ?? "",
      attendanceId: state.user.attendanceId ?? 0,
      endDate: state.user.endDate ?? "",
      originLocationId: state.user.originLocationId ?? "",
    );
    dI<UserBloc>().add(UpdateProfileEvent(updateProfileRequest: updateProfileRequest));
  }

  _setPhoneNumber(String value) {
    setState(() {
      phoneNumber = value;
    });
  }

  _setGender(GenderEnum value) {
    setState(() {
      gender = value;
    });
  }

  _setAddress(String value) {
    setState(() {
      address = value;
    });
  }

  _setProvince(String value) {
    setState(() {
      province = value;
    });
  }

  _setDistrict(String value) {
    setState(() {
      district = value;
    });
  }

  _setWard(String value) {
    setState(() {
      ward = value;
    });
  }

  _setFirstName(String value) {
    setState(() {
      firstName = value;
    });
  }

  _setLastName(String value) {
    setState(() {
      lastName = value;
    });
  }
}
