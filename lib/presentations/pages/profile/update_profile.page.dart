// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/domain/entities/address.dart';
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
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/update_profile_dialog.dart';
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
  String? dateOfBirth, phoneNumber, address, firstName, lastName;
  Address? province, ward, district;
  File file = File('');
  GenderEnum? gender = GenderEnum.male;

  @override
  void initState() {
    super.initState();
    dI<UserBloc>().add(const GetUserInfo());
  }

  _listener(BuildContext context, UserState state) {
    if (state.status == UserStatus.getUserInfoSuccess) {
      setState(() {
        dateOfBirth = state.user.dayOfBirth;
        phoneNumber = state.user.phoneNumber;
        firstName = state.user.firstName;
        lastName = state.user.lastName;
        province = Address(
            name: state.user.residentProvince, id: state.user.residentProvinceId);
        ward = Address(name: state.user.residentWard, id: state.user.residentWardId);
        district = Address(
            name: state.user.residentDistrict, id: state.user.residentDistrictId);
        address = state.user.residentAddress;
      });
    }
    if (state.status == UserStatus.updateProfileInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    }
    if (state.status == UserStatus.updateProfileSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
    }
    if (state.status == UserStatus.updateProfileError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) => _listener(context, state),
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
                  ItemProfile(isCheck: true, onChange: (value) => _setFileAvatar(value)),
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
                            title: appLocalizations.email, content: state.user.companyEmail ?? ''),
                        ItemDateOfBirthUpdateProfile(
                          dateOfBirth: formatDMY(
                            state.user.dayOfBirth ?? '',
                          ),
                          onChangeDateOfBirth: (value) => _setDateOfBirth(value),
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isCheckOnClick(state) ? colors.blue : colors.surfaceBright),
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
    final UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
      id: state.user.id,
      firstName: firstName ?? state.user.firstName ?? "",
      lastName: lastName ?? state.user.lastName ?? "",
      dayOfBirth: dateOfBirth ?? state.user.dayOfBirth ?? "0001-01-01T00:00:00",
      gender: gender?.nameEn ?? state.user.gender ?? "",
      phoneNumber: phoneNumber ?? state.user.phoneNumber ?? "",
      residentProvince: province?.name ?? state.user.residentProvince,
      residentProvinceId: province?.id ?? state.user.residentProvinceId,
      residentDistrict: district?.name ?? state.user.residentDistrict,
      residentDistrictId: district?.id ?? state.user.residentDistrictId,
      residentWard: ward?.name ?? state.user.residentWard,
      residentWardId: ward?.id ?? state.user.residentWardId,
      residentAddress: address ?? state.user.residentAddress,
      avatarPath: state.user.avatarPath ?? "",
    );
    if (isCheckOnClick(state)) {
      updateProfileDialog(
        context,
        () => dI<UserBloc>()
            .add(UpdateProfileEvent(updateProfileRequest: updateProfileRequest, file: file)),
      );
    }
  }

  bool isCheckOnClick(UserState state) {
    RegExp regExpPhoneNumber = RegExp(checkPhoneNumberRegexExp);
    bool checkChange = firstName == state.user.firstName &&
        lastName == state.user.lastName &&
        dateOfBirth == state.user.dayOfBirth &&
        phoneNumber == state.user.phoneNumber &&
        province?.id == state.user.residentProvinceId &&
        ward?.id == state.user.residentWardId &&
        district?.id == state.user.residentDistrictId &&
        address == state.user.residentAddress &&
        gender?.nameEn == state.user.gender &&
        file.path == '';
    bool check = regExpPhoneNumber.hasMatch(phoneNumber ?? "") &&
        firstName != '' &&
        lastName != '' &&
        dateOfBirth != '' &&
        !checkChange;
    return check;
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

  _setProvince(Address? value) {
    setState(() {
      province = value;
    });
  }

  _setDistrict(Address? value) {
    setState(() {
      district = value;
    });
  }

  _setWard(Address? value) {
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

  _setFileAvatar(File value) {
    setState(() {
      file = value;
    });
  }

  _setDateOfBirth(String value) {
    setState(() {
      dateOfBirth = formatYMD(value);
    });

  }
}
