import 'dart:async';
import 'dart:io';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/user/profile/update_profile_request.dart';
import 'package:base_app/domain/entities/address.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/profile/item_address_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_constant_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_date_of_birth_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_gender_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_input_update_profile.dart';
import 'package:base_app/presentations/pages/profile/item_profile.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_save_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/profile/item_department_and_position_profile.dart';
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
  String? _address;
  Address? _province;
  Address? _ward;
  Address? _district;
  String _errorFirstName = '';
  String _errorLastName = '';
  String _firstName = '';
  String _lastName = '';
  String _phoneNumber = '';
  DateTime _dateOfBirth = DateTime.now();
  File _file = File('');
  GenderEnum _gender = GenderEnum.male;
  VehicleTypeEnum? _vehicleType;
  final String _errorDialog = '';

  @override
  void initState() {
    User user = dI<UserBloc>().state.user;
    _phoneNumber = user.phoneNumber;
    _dateOfBirth = user.dayOfBirth ?? DateTime.now();
    _firstName = user.firstName;
    _lastName = user.lastName;
    _gender = user.gender;
    _province =
        Address(id: user.residentProvinceId, name: user.residentProvince);
    _ward = Address(id: user.residentWardId, name: user.residentWard);
    _district =
        Address(id: user.residentDistrictId, name: user.residentDistrict);
    super.initState();
  }

  listener(String errorCode) {
    setState(() {
      errorCode = errorCode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          appLocalizations.editPersonalInformation,
          style: TextStyle(
            fontSize: SpacingUnit.x4_5,
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) => listener(state.errorCode),
        builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            color: colors.outline.withOpacity(0.1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ItemProfile(
                    isCheck: true,
                    onChange: (value) => _setFileAvatar(value),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: SpacingUnit.x4),
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x2),
                      color: colors.background,
                      border: Border.all(
                        color: colors.background,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemUpdateProfileConstant(
                            checkOpacity: true,
                            title: appLocalizations.employeeCode,
                            content: state.user.code),
                        ItemUpdateProfileConstant(
                            checkOpacity: true,
                            title: appLocalizations.companyEmail,
                            content: state.user.companyEmail),
                        ItemDateOfBirthUpdateProfile(
                          title: appLocalizations.dateOfBirth,
                          dateOfBirth: state.user.dayOfBirth ?? DateTime.now(),
                          onChangeDateOfBirth: (value) =>
                              _setDateOfBirth(value),
                        ),
                        ItemInputUpdateProfile(
                          requiredValidate: true,
                          error: _errorFirstName,
                          title: appLocalizations.firstName,
                          content: state.user.firstName,
                          onChange: (value) => _setFirstName(value),
                        ),
                        ItemInputUpdateProfile(
                          requiredValidate: true,
                          error: _errorLastName,
                          title: appLocalizations.lastName,
                          content: state.user.lastName,
                          onChange: (value) => _setLastName(value),
                        ),
                        ItemInputUpdateProfile(
                          requiredValidate: true,
                          title: appLocalizations.phoneNumber,
                          content: state.user.phoneNumber,
                          onChange: (value) => _setPhoneNumber(value),
                        ),
                        ItemGenderUpdateProfile(
                            onChangeGender: (value) => _setGender(value),
                            gender: state.user.gender),
                        ItemAddressUpdateProfile(
                            province: Address(
                                id: state.user.residentProvinceId,
                                name: state.user.residentProvince),
                            district: Address(
                                id: state.user.residentDistrictId,
                                name: state.user.residentDistrict),
                            ward: Address(
                                id: state.user.residentWardId,
                                name: state.user.residentWard),
                            onChangeProvince: (value) => _setProvince(value),
                            onChangeDistrict: (value) => _setDistrict(value),
                            onChangeWard: (value) => _setWard(value)),
                        ItemInputUpdateProfile(
                          title: appLocalizations.address,
                          content: state.user.residentAddress,
                          onChange: (value) => _setAddress(value),
                        ),
                        const ItemDepartmentAndPositionProfile(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x5,
                  ),
                  AppButton(
                    color: colors.blue,
                    colorText: colors.background,
                    title: appLocalizations.saveUpdateInfo,
                    onSubmit: () => _updateProfile(context, state.user),
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
      firstName: _firstName,
      lastName: _lastName,
      dayOfBirth: _dateOfBirth,
      gender: _gender.name,
      phoneNumber: _phoneNumber,
      residentProvince: _province?.name,
      residentProvinceId: (_province != null &&
              _province!.id != null &&
              _province!.id!.isNotEmpty)
          ? _province!.id
          : null,
      residentDistrict: _district?.name,
      residentDistrictId: (_district != null &&
              _district!.id != null &&
              _district!.id!.isNotEmpty)
          ? _district!.id
          : null,
      residentWard: _ward?.name,
      residentWardId:
          (_ward != null && _ward!.id != null && _ward!.id!.isNotEmpty)
              ? _ward!.id
              : null,
      residentAddress:
          setValueOnUpdateProfileRequest(_address, user.residentAddress),
      avatarPath: setPath(user.avatarPath),
      vehicleType: setValueOnUpdateProfileRequest(
        _vehicleType?.name,
        user.vehicleType.name,
      ),
    );
    setState(() {
      if (_firstName == '') {
        _errorFirstName = appLocalizations.cannotBeLeftBlank;
      }
      if (_lastName == '') {
        _errorLastName = appLocalizations.cannotBeLeftBlank;
      }
    });
    if (isCheckOnClick(user)) {
      dialogCheckSave(
        context: context,
        title: appLocalizations.doYouWantToUpdateProfile,
        callback: () => updateProfile(updateProfileRequest),
      );
    }
  }

  updateProfile(UpdateProfileRequest updateProfileRequest) async {
    final Completer completer = Completer<bool>();
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
    dialogIndicator(context: currentContext);
    dI<UserBloc>().add(
      UpdateProfileEvent(
        updateProfileRequest: updateProfileRequest,
        file: _file,
        completer: completer,
      ),
    );
    final checkCompleter = await completer.future;
    if (checkCompleter) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      updateProfileSuccess();
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      updateProfileFail(errorDialog: _errorDialog);
    }
  }

  bool isCheckOnClick(User user) {
    RegExp regExpPhoneNumber = RegExp(checkPhoneNumberRegexExp);
    bool check =
        (regExpPhoneNumber.hasMatch(_phoneNumber) || _phoneNumber.isNotEmpty) &&
            _firstName != '' &&
            _lastName != '';
    return check;
  }

  _setPhoneNumber(String value) {
    setState(() {
      _phoneNumber = value;
    });
  }

  _setGender(GenderEnum value) {
    setState(() {
      _gender = value;
    });
  }

  _setAddress(String value) {
    setState(() {
      _address = value;
    });
  }

  _setProvince(Address? value) {
    setState(() {
      _province = value;
    });
  }

  _setDistrict(Address? value) {
    setState(() {
      _district = value;
    });
  }

  _setWard(Address? value) {
    setState(() {
      _ward = value;
    });
  }

  _setFirstName(String value) {
    setState(() {
      _firstName = value;
    });
  }

  _setLastName(String value) {
    setState(() {
      _lastName = value;
    });
  }

  _setFileAvatar(File value) async {
    setState(() {
      _file = value;
    });
  }

  _setDateOfBirth(DateTime value) {
    setState(() {
      _dateOfBirth = value;
    });
  }
}
