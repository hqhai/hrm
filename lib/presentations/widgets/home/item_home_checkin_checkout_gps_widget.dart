import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemHomeCheckInCheckOutGPSWidget extends StatefulWidget {
  const ItemHomeCheckInCheckOutGPSWidget({super.key});

  @override
  State<ItemHomeCheckInCheckOutGPSWidget> createState() => _ItemHomeCheckInCheckOutGPSWidgetState();
}

class _ItemHomeCheckInCheckOutGPSWidgetState extends State<ItemHomeCheckInCheckOutGPSWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: SpacingUnit.x4_5),
            Text(
              appLocalizations.checkInOut,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
            ),
            BlocBuilder<AttendanceBloc, AttendanceState>(
              builder: (context, stateAttendance) {
                return Container(
                  padding: const EdgeInsets.all(SpacingUnit.x3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SpacingUnit.x2),
                    color: CustomsColor.colorBackground,
                    border: Border.all(
                      color: colors.text,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SvgPicture.asset(
                                        Assets.images.icon.home.mingcuteTimeLine,
                                        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Text(
                                        stateAttendance.attendance.checkIn ?? "---------",
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: SpacingUnit.x3,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: SvgPicture.asset(
                                        Assets.images.icon.home.icBaselinePlace,
                                        colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 8,
                                      child: Text(
                                        setAddressDepartment(state),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x3,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 4,
                            child: SvgPicture.asset(
                              Assets.images.icon.home.phFingerprintFill,
                              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                              height: width * 0.35,
                              width: width * 0.35,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => nextTimekeepingGPSScreen(context),
                        child: Text(
                          appLocalizations.touchTheIconToTimeClock,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3_5,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  String setAddressDepartment(UserState state){
    if(state.user.userDepartmentPositions.isNotEmpty) {
      return state.user.userDepartmentPositions.first.department?.address ?? "";
    }
    else{
      return "";
    }
  }

  nextTimekeepingGPSScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.timekeepingGPSPage);
  }
}
