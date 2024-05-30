import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemTimeKeepingGPS extends StatefulWidget {
  const ItemTimeKeepingGPS({super.key});

  @override
  State<ItemTimeKeepingGPS> createState() => _ItemTimeKeepingGPSState();
}

class _ItemTimeKeepingGPSState extends State<ItemTimeKeepingGPS> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                height: width * 0.2,
                width: width * 0.2,
                Assets.images.icon.home.phFingerprintFill,
                colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
              ),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: SvgPicture.asset(
                    Assets.images.icon.home.mingcuteTimeLine,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                ),
                BlocBuilder<AttendanceBloc, AttendanceState>(
                  builder: (context, stateAttendance) {
                    return Expanded(
                      flex: 8,
                      child: Text(
                        stateAttendance.attendance.checkIn ?? "---------",
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x3,
                        ),
                      ),
                    );
                  },
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
        );
      },
    );
  }

  String setAddressDepartment(UserState state) {
    if (state.user.userDepartmentPositions.isNotEmpty) {
      return state.user.userDepartmentPositions.first.department?.address ?? "";
    } else {
      return "";
    }
  }

}
