// ignore_for_file: use_build_context_synchronously

import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
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

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
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
                              state.user.avatarPath,
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
                                  state.user.fullName,
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
                                        state.user.phoneNumber,
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
                                        state.user.email,
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: SpacingUnit.x3),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      appLocalizations.employeeCode,
                                      style: TextStyle(
                                          color: colors.tertiary, fontSize: SpacingUnit.x3),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Container(
                                      width: width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: colors.text,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        state.user.id,
                                        maxLines: 1,
                                        overflow: TextOverflow.clip,
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x3,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Text(
                                      appLocalizations.personalEmail,
                                      style: TextStyle(
                                          color: colors.tertiary, fontSize: SpacingUnit.x3),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Container(
                                      width: width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: colors.text,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        state.user.email,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Text(
                                      appLocalizations.gender,
                                      style: TextStyle(
                                          color: colors.tertiary, fontSize: SpacingUnit.x3),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Container(
                                      width: width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: colors.text,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        state.user.type,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Text(
                                      appLocalizations.department,
                                      style: TextStyle(
                                          color: colors.tertiary, fontSize: SpacingUnit.x3),
                                    ),
                                    const SizedBox(
                                      height: SpacingUnit.x4_5,
                                    ),
                                    Container(
                                      width: width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: colors.text,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        state.user.department,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style:
                                            TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    appLocalizations.dateOfBirth,
                                    style:
                                        TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x3),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Container(
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: colors.text,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      state.user.id,
                                      maxLines: 1,
                                      overflow: TextOverflow.clip,
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Text(
                                    appLocalizations.phoneNumber,
                                    style:
                                        TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x3),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Container(
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: colors.text,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      state.user.phoneNumber,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Text(
                                    appLocalizations.address,
                                    style:
                                        TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x3),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Container(
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: colors.text,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      state.user.department,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Text(
                                    appLocalizations.branch,
                                    style:
                                        TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x3),
                                  ),
                                  const SizedBox(
                                    height: SpacingUnit.x4_5,
                                  ),
                                  Container(
                                    width: width * 0.5,
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: colors.text,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      state.user.type,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: SpacingUnit.x4_5,
                        ),
                        Text(
                          appLocalizations.position,
                          style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x3),
                        ),
                        const SizedBox(
                          height: SpacingUnit.x4_5,
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: colors.text,
                                width: 1,
                              ),
                            ),
                          ),
                          child: Text(
                            state.user.type,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                          ),
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
