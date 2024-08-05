// ignore_for_file: use_build_context_synchronously

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/profile/item_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_department_and_position_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_text_content_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_text_title_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_vehicle_proflie.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ProfileWidget extends StatefulWidget {
  const ProfileWidget({
    super.key,
  });

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  void initState() {
    super.initState();
  }

  bool checkListenWhen(UserStatus status, UserStatus status2) {
    return status != status2;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) => _listener(state.status),
        listenWhen: (previous, current) => checkListenWhen(
          previous.status,
          current.status,
        ),
        builder: (context, state) {
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            margin:
                const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
            height: MediaQuery.sizeOf(context).height,
            decoration: BoxDecoration(
              color: colors.background,
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
                      color: colors.background,
                      border: Border.all(
                        color: colors.text,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemTitleProfile(
                          title1: appLocalizations.employeeCode,
                          title2: appLocalizations.dateOfBirth,
                        ),
                        ItemContentProfile(
                          content1: state.user.code,
                          content2: formatDMY(state.user.dayOfBirth),
                        ),
                        ItemTitleProfile(
                          title1: appLocalizations.companyEmail,
                          title2: appLocalizations.phoneNumber,
                        ),
                        ItemContentProfile(
                            content1: state.user.companyEmail,
                            content2: state.user.phoneNumber),
                        ItemTitleProfile(
                          title1: appLocalizations.gender,
                          title2: appLocalizations.address,
                        ),
                        ItemContentProfile(
                          content1: state.user.gender.configGenderName,
                          content2: _setAddress(state.user),
                        ),
                        ItemTitleProfile(
                          title1: appLocalizations.department,
                          title2: appLocalizations.position,
                        ),
                        ItemDepartmentAndPositionProfile(
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
                        const ItemVehicleProfile(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _listener(UserStatus status) {
    if (status == UserStatus.success) {
      dI<UserBloc>().add(const GetUserInfo());
    }
  }

  String _setAddress(User user) {
    String? province = '', district = '', ward = '', address = '';

    if(user.residentAddress.isNotEmpty){
      address = user.residentAddress;
    }
    if(user.residentWard.isNotEmpty){
      ward = "${user.residentWard}, ";
    }
    if(user.residentDistrict.isNotEmpty){
      district = "${user.residentDistrict}, ";
    }
    if(user.residentProvince.isNotEmpty){
      province = "${user.residentDistrict}, ";
    }
    return province + district + ward + address;
  }
}
