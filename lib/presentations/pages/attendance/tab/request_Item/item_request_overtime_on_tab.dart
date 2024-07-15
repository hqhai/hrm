import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_link_next_screen.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequestOverTimeOnTab extends StatelessWidget {
  const ItemRequestOverTimeOnTab({
    super.key,
    required this.id,
    required this.dateTime,
  });

  final String id;
  final DateTime dateTime;

  Request requestById(List<Request> requests) {
    return requests.firstWhere((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, stateAttendance) {
        final userWorkingHistoryModel =
            userWorkingHistoryModelByDate(stateAttendance.attendance.userWorkingHistories);
        return BlocBuilder<RequestWorkSheetBloc, RequestWorkSheetState>(
          builder: (context, state) {
            final request = state.mapRequests[id];
            return ContainerBorder(
                borderColors: colors.surfaceVariantHigh,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            request?.flowType.configTypeName ?? "",
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: AppLinkNextScreen(
                            callback: () => _nextScreenRequest(context),
                          ),
                        )
                      ],
                    ),
                    TitleValueLeave(
                      title: appLocalizations.totalOTHours,
                      value: setTotalOT(
                        request?.config.overTimes,
                      ),
                      size: SpacingUnit.x4,
                      padding: SpacingUnit.x3,
                    ),
                    TitleValueLeave(
                      title: appLocalizations.dateType,
                      value: userWorkingHistoryModel.overTimeDay?.configEnumOvertimeDayName ?? "",
                      size: SpacingUnit.x4,
                      padding: SpacingUnit.x3,
                    ),
                    TitleValueLeave(
                      title: appLocalizations.oTCoefficient,
                      value: userWorkingHistoryModel.overTimeRate.toString(),
                      size: SpacingUnit.x4,
                      padding: SpacingUnit.x3,
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  String intervalOnLeave(DateTime? startDate, DateTime? endDate) {
    String start = (startDate ?? '').toString();
    String end = (endDate ?? '').toString();
    return '${formatYMD(start)} - ${formatYMD(end)}';
  }

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
  }

  _nextScreenRequest(BuildContext context) {}

  String setTotalOT(List<RequisitionOverTime>? overTimes) {
    final listOT = overTimes ?? [];
    final index = listOT.indexWhere((element) => element.date == dateTime);
    if (index != -1) {
      final time = listOT[index].suggestTime ?? 0;
      return (time / 3600).toString();
    }
    return '';
  }
}
