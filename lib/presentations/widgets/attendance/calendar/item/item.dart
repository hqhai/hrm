import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemCalender extends StatelessWidget {
  final bool isNowDate;
  final DateTime date;
  final int month;
  final int displayType;

  const ItemCalender({
    super.key,
    required this.date,
    required this.isNowDate,
    required this.month,
    required this.displayType,
  });

  UserWorkingHistoryModel? userWorkingHistoryModelByDate(
      List<UserWorkingHistoryModel> list) {
    final int index = list
        .indexWhere((element) => element.date?.isAtSameMomentAs(date) ?? false);
    if (index != -1) {
      return list[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel = userWorkingHistoryModelByDate(
          state.attendance.userWorkingHistories,
        );
        return GestureDetector(
          onTap: () =>
              _nextItemAttendanceHistoryPage(context, userWorkingHistoryModel),
          child: Container(
            color: colors.background,
            child: Padding(
              padding: const EdgeInsets.all(SpacingUnit.x1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(SpacingUnit.x1),
                      margin: const EdgeInsets.only(
                          top: SpacingUnit.x1, bottom: SpacingUnit.x3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SpacingUnit.x10),
                        color: isNowDate ? colors.primary : Colors.transparent,
                      ),
                      child: Text(
                        date.day.toString(),
                        style: TextStyle(
                          color: _colorText(context),
                          fontSize: SpacingUnit.x3_5,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: value(context, userWorkingHistoryModel),
                  ),
                  Expanded(
                    child: check(userWorkingHistoryModel)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: userWorkingHistoryModel!.status
                                .mapIndexed(
                                  (index, element) => Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(SpacingUnit.x2),
                                      color: _color(context, index,
                                          userWorkingHistoryModel.status),
                                    ),
                                    margin:
                                        const EdgeInsetsDirectional.symmetric(
                                            horizontal: SpacingUnit.x0_5,
                                            vertical: SpacingUnit.x2),
                                    width: SpacingUnit.x1_5,
                                    height: SpacingUnit.x1_5,
                                  ),
                                )
                                .toList(),
                          )
                        : const SizedBox(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool check(UserWorkingHistoryModel? userWorkingHistoryModel) {
    return userWorkingHistoryModel != null &&
        userWorkingHistoryModel.status.isNotEmpty;
  }

  Color _colorText(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return month != date.month
        ? colors.neutralVariant40
        : (isNowDate ? Colors.white : colors.text);
  }

  Color _color(
      BuildContext context, int index, List<UserWorkingHistoryStatus> list) {
    final colors = AppTheme.getColors(context);
    switch (list[index]) {
      case UserWorkingHistoryStatus.onTime:
        return colors.success;
      case UserWorkingHistoryStatus.late:
        return colors.tertiary;
      case UserWorkingHistoryStatus.early:
        return colors.tertiary;
      case UserWorkingHistoryStatus.forgotChecking:
        return colors.tertiary;
      case UserWorkingHistoryStatus.offWork:
        return colors.surface;
      case UserWorkingHistoryStatus.isRequest:
        return colors.primary;
      case UserWorkingHistoryStatus.holiday:
        return colors.sunriseYellow;
      case UserWorkingHistoryStatus.noAttendance:
        return colors.cyan;
      case UserWorkingHistoryStatus.offSet:
        return colors.goldenPurple;
    }
  }

  _nextItemAttendanceHistoryPage(
    BuildContext context,
    UserWorkingHistoryModel? userWorkingHistoryModel,
  ) {
    if (userWorkingHistoryModel != null) {
      dI<AppNavigation>().pushName(context,
          page: Pages.historyAttendancePage, extra: {'dateTime': date});
    }
  }

  Widget value(
      BuildContext context, UserWorkingHistoryModel? userWorkingHistoryModel) {
    final colors = AppTheme.getColors(context);
    switch (displayType) {
      case 2:
        return Column(
          children: [
            Text(
              strSeconds(userWorkingHistoryModel?.checkIn) ?? '',
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x2_5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: SpacingUnit.x1,
              ),
              child: Text(
                userWorkingHistoryModel?.checkIn != null ? '-' : '',
              ),
            ),
            Text(
              strSeconds(userWorkingHistoryModel?.checkOut) ?? '',
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x2_5,
              ),
            ),
          ],
        );
      case 1:
        return Text(
          Duration(
                  seconds: userWorkingHistoryModel?.workTimeActual.toInt() ?? 0)
              .inHours
              .toString(),
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x2_5,
          ),
        );
      case 3:
        return Text(
          (userWorkingHistoryModel?.salaryRate ?? 0).toString(),
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x2_5,
          ),
        );
      default:
        return Container();
    }
  }
}
