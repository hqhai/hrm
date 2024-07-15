import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomTimeSheetWidget extends StatefulWidget {
  const BottomTimeSheetWidget({super.key, required this.onChange});

  final ValueChanged<RequisitionOverTime> onChange;

  @override
  State<BottomTimeSheetWidget> createState() => _BottomTimeSheetWidgetState();
}

class _BottomTimeSheetWidgetState extends State<BottomTimeSheetWidget> {
  bool checkInOrOut = true;

  @override
  void initState() {
    final String id = dI<UserBloc>().state.user.id;
    final DateTime now = DateTime.now();
    dI<AttendanceBloc>().add(GetAttendanceEvent(id: id, month: now.month, year: now.year));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        return Container(
          height: height * 0.4,
          color: colors.surface,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () => setCheck(),
                      child: ContainerBorder(
                        child: Text(
                          checkInOrOut ? appLocalizations.youLater : appLocalizations.youEarly,
                          style: TextStyle(
                            fontSize: SpacingUnit.x4,
                            color: colors.text,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 4,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: dates(state.attendance.userWorkingHistories)
                          .mapIndexed((index, element) => GestureDetector(
                                onTap: () => addDate(date: dates(state.attendance.userWorkingHistories)[index]),
                                child: Container(
                                  padding: const EdgeInsets.all(SpacingUnit.x2),
                                  margin: const EdgeInsets.all(SpacingUnit.x2),
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
                                      Text(
                                        '${index + 1}.    ',
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x3,
                                        ),
                                      ),
                                      Text(
                                        formatYMD(dates(state.attendance.userWorkingHistories)[index]
                                            .date
                                            .toString()),
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool checkCheckIn(String checkIn) {
    if (checkIn.isEmpty) {
      return true;
    }
    List<String> timePartsIn = formatHMByH(checkIn).split(':');
    int hourIn = int.parse(timePartsIn[0]);
    int minuteIn = int.parse(timePartsIn[1]);
    return hourIn > 8 || (hourIn == 8 && minuteIn > 30);
  }

  bool checkCheckOut(String checkOut) {
    if (checkOut.isEmpty) {
      return true;
    }
    List<String> timePartsOut = formatHMByH(checkOut).split(':');
    int hourOut = int.parse(timePartsOut[0]);
    int minuteOut = int.parse(timePartsOut[1]);
    return hourOut < 18 || (hourOut == 18 && minuteOut < 20);
  }

  List<UserWorkingHistoryModel> dates(List<UserWorkingHistoryModel> attendances) {
    final List<UserWorkingHistoryModel> listAttendance = [];
    attendances.forEachIndexed((index, element) {
      if ((element.status?? []).contains(UserWorkingHistoryStatus.early) ||
          (element.status?? []).contains(UserWorkingHistoryStatus.late)) {
        listAttendance.add(element);
      }
    });
    return listAttendance;
  }

  addDate({required UserWorkingHistoryModel date}) {
    setState(() {
      final RequisitionOverTime dateUnit = RequisitionOverTime(
        date: date.date,
      );
      widget.onChange.call(dateUnit);
      Navigator.of(context).pop();
    });
  }

  String strSeconds(int time) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return formatHM(result.toString());
  }

  setCheck() {
    setState(() {
      checkInOrOut = !checkInOrOut;
    });
  }
}
