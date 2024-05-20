// ignore_for_file: use_build_context_synchronously

import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/pages/profile/item_textfield_content_update_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_department_and_position_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_text_content_profile.dart';
import 'package:base_app/presentations/widgets/profile/item_text_title_profile.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final updateProfilePageRoute =
    GoRoute(path: Pages.updateProfilePage, builder: (context, GoRouterState state) => const UpdateProfilePage());

class UpdateProfilePage extends StatefulWidget {
  const UpdateProfilePage({
    super.key,
  });

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  String code = '', email = '', gender = '', dateOfBirth = '', phoneNumber = '', address = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
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
                  Container(
                    padding: const EdgeInsets.all(SpacingUnit.x3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x2),
                      color: CustomsColor.colorBackground,
                      border: Border.all(
                        color: colors.text,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 30,
                            child: Image.network(
                              state.user.avatarPath ?? "",
                              fit: BoxFit.fill,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  Assets.images.error.imageError.path,
                                  fit: BoxFit.fill,
                                );
                              },
                            )),
                        Expanded(
                          flex: 70,
                          child: Padding(
                            padding: const EdgeInsets.only(left: SpacingUnit.x4),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.user.fullName ?? "",
                                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
                                ),
                                const SizedBox(height: SpacingUnit.x5),
                                Row(
                                  children: [
                                    Text(
                                      '${appLocalizations.phoneNumber} : ',
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                    ),
                                    Expanded(
                                      child: Text(
                                        state.user.phoneNumber ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style:
                                            TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x1_5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '${appLocalizations.email} : ',
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                    ),
                                    Expanded(
                                      child: Text(
                                        maxLines: 2,
                                        overflow: TextOverflow.clip,
                                        state.user.email ?? "",
                                        style:
                                            TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
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
                        ItemTitleProfile(
                          title1: appLocalizations.employeeCode,
                          title2: appLocalizations.dateOfBirth,
                        ),
                        ItemCodeAndDateOfBirthUpdateProfile(
                          code: state.user.code ?? '',
                          dateOfBirth: formatDMY(
                            state.user.dayOfBirth ?? '',
                          ),
                          onChangeCode: (value) => code = value,
                          onChangeDateOfBirth: (value) => dateOfBirth = formatYMD(value),
                        ),
                        ItemTitleProfile(
                          title1: appLocalizations.personalEmail,
                          title2: appLocalizations.phoneNumber,
                        ),
                        ItemContentProfile(
                            content1: state.user.email ?? "",
                            content2: state.user.phoneNumber ?? ""),
                        ItemTitleProfile(
                          title1: appLocalizations.gender,
                          title2: appLocalizations.address,
                        ),
                        ItemContentProfile(
                          content1: state.user.gender ?? "",
                          content2:
                              "${state.user.residentAddress ?? ""}, ${state.user.residentWard ?? ""}, ${state.user.residentDistrict ?? ""},${state.user.residentProvince ?? ""}",
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
}
