import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/profile/item_profile.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_title_value_colum.dart';
import 'package:base_app/presentations/widgets/profile/item_department_and_position_profile.dart';
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
            padding: const EdgeInsets.all(SpacingUnit.x4),
            color: colors.outline.withOpacity(0.1),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const ItemProfile(),
                  Container(
                    margin: const EdgeInsets.only(top: SpacingUnit.x4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: SpacingUnit.x4,
                      vertical: SpacingUnit.x2,
                    ),
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
                        ItemTitleValueColum(
                          font: FontWeight.w600,
                          size: SpacingUnit.x4,
                          title: appLocalizations.dateOfBirth,
                          value: formatDMY(state.user.dayOfBirth.toString()),
                        ),
                        ItemTitleValueColum(
                          font: FontWeight.w600,
                          size: SpacingUnit.x4,
                          title: appLocalizations.companyEmail,
                          value: state.user.companyEmail,
                        ),
                        ItemTitleValueColum(
                          font: FontWeight.w600,
                          size: SpacingUnit.x4,
                          title: appLocalizations.phoneNumber,
                          value: state.user.phoneNumber,
                        ),
                        ItemTitleValueColum(
                          font: FontWeight.w600,
                          size: SpacingUnit.x4,
                          title: appLocalizations.gender,
                          value: state.user.gender.configGenderName,
                        ),
                        ItemTitleValueColum(
                          font: FontWeight.w600,
                          size: SpacingUnit.x4,
                          title: appLocalizations.address,
                          value: _setAddress(state.user),
                        ),
                        const ItemDepartmentAndPositionProfile(),
                        // ItemTitleValueColum(
                        //   font: FontWeight.w600,
                        //   size: SpacingUnit.x4,
                        //   title: appLocalizations.vehicleType,
                        //   value: state.user.vehicleType.configVehicleTypeName,
                        // ),
                        // ItemTitleValueColum(
                        //   font: FontWeight.w600,
                        //   size: SpacingUnit.x4,
                        //   title: appLocalizations.licensePlate,
                        //   value: state.user.licensePlate,
                        // ),
                        // ItemTitleValueColum(
                        //   font: FontWeight.w600,
                        //   size: SpacingUnit.x4,
                        //   title: appLocalizations.autoMaker,
                        //   value: state.user.autoMaker,
                        // ),
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

    if (user.residentAddress.isNotEmpty) {
      address = user.residentAddress;
    }
    if (user.residentWard.isNotEmpty) {
      ward = "${user.residentWard}, ";
    }
    if (user.residentDistrict.isNotEmpty) {
      district = "${user.residentDistrict}, ";
    }
    if (user.residentProvince.isNotEmpty) {
      province = "${user.residentProvince}, ";
    }
    return province + district + ward + address;
  }
}
