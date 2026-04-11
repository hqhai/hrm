import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_event.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_business_on_tab.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_explanation_on_tab.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_late_or_early_on_tab.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_leave_on_tab.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_make_up_on_tab.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_overtime_on_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RequestTab extends StatefulWidget {
  const RequestTab({super.key, required this.dateTime});

  final DateTime dateTime;

  @override
  State<RequestTab> createState() => _RequestTabState();
}

class _RequestTabState extends State<RequestTab> {
  @override
  void initState() {
    final list = dI<AttendanceBloc>().state.attendance.userWorkingHistories;
    final userWorkingHistoryModel = userWorkingHistoryModelByDate(list);
    dI<RequestWorkSheetBloc>().add(GetRequestsByIdsEvent(
      ids: userWorkingHistoryModel?.requestIds ?? [],
    ));
    super.initState();
  }

  UserWorkingHistoryModel? userWorkingHistoryModelByDate(
      List<UserWorkingHistoryModel> list) {
    for (final element in list) {
      final d = element.date;
      if (d == null) continue;
      if (d.year == widget.dateTime.year &&
          d.month == widget.dateTime.month &&
          d.day == widget.dateTime.day) {
        return element;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RequestWorkSheetBloc, RequestWorkSheetState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: state.requestIds
                .map(
                  (e) => Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
                    child: item(
                      state.mapRequests[e],
                      e,
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }

  Widget item(Request? request, String e) {
    switch (request?.flowType) {
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        return ItemRequestOnTab(id: e);
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        return ItemRequestOnTab(id: e);
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        return ItemRequestOnTab(id: e);
      case RequisitionTypeEnum.explanation:
        return ItemRequestExplanationOnTab(id: e);
      case RequisitionTypeEnum.lateOrEarly:
        return ItemRequestLateOrEarlyOnTab(
          id: e,
          dateTime: widget.dateTime,
        );
      case RequisitionTypeEnum.bussiness:
        return ItemRequestBusinessOnTab(id: e);
      case RequisitionTypeEnum.overTime:
        return ItemRequestOverTimeOnTab(
          id: e,
          dateTime: widget.dateTime,
        );
      case RequisitionTypeEnum.makeUpWork:
        return ItemRequestMakeUpOnTab(
          id: e,
        );
      default:
        return const SizedBox();
    }
  }
}
