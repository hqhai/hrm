// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/entities/user.dart';
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
import 'package:base_app/presentations/pages/profile/item_vehicle_update_profile.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
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
  String? phoneNumber, address, licensePlate, autoMaker;
  Address? province, ward, district;
  String errorFirstName = '', errorLastName = '', firstName = '', lastName = '', dateOfBirth = '';
  File file = File('');
  GenderEnum gender = GenderEnum.male;
  VehicleTypeEnum? vehicleType;

  @override
  void initState() {
    User user = dI<UserBloc>().state.user;
    dateOfBirth = user.dayOfBirth;
    firstName = user.firstName;
    lastName = user.lastName;
    gender = user.gender;
    super.initState();
  }

  _listener(BuildContext context, UserState state) {
    Navigator.of(context).pop();
    successDialog(context);
  }

  bool checkListenWhen(BuildContext context, UserState stateP, UserState stateC) {
    if (stateC.status == UserStatus.fail && stateP.user != stateC.user) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
    return stateP.user != stateC.user;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) => _listener(context, state),
        listenWhen: (previous, current) => checkListenWhen(
          context,
          previous,
          current,
        ),
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
                            title: appLocalizations.employeeCode, content: state.user.code),
                        ItemUpdateProfileConstant(
                            title: appLocalizations.companyEmail, content: state.user.companyEmail),
                        ItemDateOfBirthUpdateProfile(
                          title: appLocalizations.dateOfBirth,
                          dateOfBirth: formatDMY(
                            state.user.dayOfBirth,
                          ),
                          onChangeDateOfBirth: (value) => _setDateOfBirth(value),
                        ),
                        ItemInputUpdateProfile(
                          error: errorFirstName,
                          title: appLocalizations.firstName,
                          content: state.user.firstName,
                          onChange: (value) => _setFirstName(value),
                        ),
                        ItemInputUpdateProfile(
                          error: errorLastName,
                          title: appLocalizations.lastName,
                          content: state.user.lastName,
                          onChange: (value) => _setLastName(value),
                        ),
                        ItemInputUpdateProfile(
                          title: appLocalizations.phoneNumber,
                          content: state.user.phoneNumber,
                          onChange: (value) => _setPhoneNumber(value),
                        ),
                        ItemGenderUpdateProfile(
                            onChangeGender: (value) => _setGender(value),
                            gender: state.user.gender),
                        ItemAddressUpdateProfile(
                            province: Address(
                                id: state.user.originProvinceId, name: state.user.originProvince),
                            district: Address(
                                id: state.user.originDistrictId, name: state.user.originDistrict),
                            ward: Address(id: state.user.originWardId, name: state.user.originWard),
                            onChangeProvince: (value) => _setProvince(value),
                            onChangeDistrict: (value) => _setDistrict(value),
                            onChangeWard: (value) => _setWard(value)),
                        ItemInputUpdateProfile(
                          title: appLocalizations.address,
                          content: state.user.residentAddress,
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
                        ItemVehicleUpdateProfile(
                          vehicle: state.user.vehicleType,
                          onChangeVehicle: (value) => _onChangeVehicle(value),
                        ),
                        ItemInputUpdateProfile(
                          title: appLocalizations.licensePlate,
                          content: state.user.licensePlate,
                          onChange: (value) => _setLicensePlate(value),
                        ),
                        ItemInputUpdateProfile(
                          title: appLocalizations.autoMaker,
                          content: state.user.autoMaker,
                          onChange: (value) => _setAutoMaker(value),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x5,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.blue,
                    ),
                    onPressed: () => _updateProfile(context, state.user),
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

  String? setValueOnUpdateProfileRequest(String? value1, String value2) {
    if (value1 == null && value2 == '') {
      return value1;
    } else if (value1 == null) {
      return value2;
    }
    return value1;
  }

  String? setPath(String path) {
    if (path == '') {
      return null;
    }
    return path;
  }

  _updateProfile(BuildContext context, User user) {
    final appLocalizations = AppLocalizations.of(context)!;
    final UpdateProfileRequest updateProfileRequest = UpdateProfileRequest(
      id: user.id,
      firstName: firstName,
      lastName: lastName,
      dayOfBirth: dateOfBirth,
      gender: gender.name,
      phoneNumber: setValueOnUpdateProfileRequest(
        phoneNumber,
        user.phoneNumber,
      ),
      residentProvince: setValueOnUpdateProfileRequest(
        province?.name,
        user.residentProvince,
      ),
      residentProvinceId: setValueOnUpdateProfileRequest(
        province?.id,
        user.residentProvinceId,
      ),
      residentDistrict: setValueOnUpdateProfileRequest(
        district?.name,
        user.residentDistrict,
      ),
      residentDistrictId: setValueOnUpdateProfileRequest(
        district?.id,
        user.residentDistrictId,
      ),
      residentWard: setValueOnUpdateProfileRequest(
        ward?.name,
        user.residentWard,
      ),
      residentWardId: setValueOnUpdateProfileRequest(
        ward?.id,
        user.residentWardId,
      ),
      residentAddress: setValueOnUpdateProfileRequest(address, user.residentAddress),
      avatarPath: setPath(user.avatarPath),
      autoMaker: setValueOnUpdateProfileRequest(
        autoMaker,
        user.autoMaker,
      ),
      licensePlate: setValueOnUpdateProfileRequest(
        licensePlate,
        user.licensePlate,
      ),
      vehicleType: setValueOnUpdateProfileRequest(
        vehicleType?.name,
        user.vehicleType.name,
      ),
    );
    setState(() {
      if (firstName == '') {
        errorFirstName = appLocalizations.cannotBeLeftBlank;
      }
      if (lastName == '') {
        errorLastName = appLocalizations.cannotBeLeftBlank;
      }
    });
    if (isCheckOnClick(user)) {
      updateProfileDialog(context, () {
        dI<UserBloc>()
            .add(UpdateProfileEvent(updateProfileRequest: updateProfileRequest, file: file));
        Navigator.of(context).pop();
        progressIndicatorDialog(context);
      });
    }
  }

  bool isCheckOnClick(User user) {
    RegExp regExpPhoneNumber = RegExp(checkPhoneNumberRegexExp);
    bool checkChange = firstName == user.firstName &&
        lastName == user.lastName &&
        dateOfBirth == user.dayOfBirth &&
        gender == user.gender &&
        phoneNumber == null &&
        province == null &&
        ward == null &&
        district == null &&
        address == null &&
        file.path == '' &&
        autoMaker == null &&
        licensePlate == null &&
        vehicleType == null;
    bool check = (regExpPhoneNumber.hasMatch(phoneNumber ?? "") || phoneNumber == null) &&
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

  _onChangeVehicle(VehicleTypeEnum value) {
    setState(() {
      vehicleType = value;
    });
  }

  _setLicensePlate(String value) {
    setState(() {
      licensePlate = value;
    });
  }

  _setAutoMaker(String value) {
    setState(() {
      autoMaker = value;
    });
  }
}
