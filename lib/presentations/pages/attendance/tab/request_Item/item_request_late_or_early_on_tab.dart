import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_link_next_screen.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

class ItemRequestLateOrEarlyOnTab extends StatefulWidget {
  const ItemRequestLateOrEarlyOnTab({
    super.key,
    required this.id,
    required this.dateTime,
  });

  final String id;
  final DateTime dateTime;

  @override
  State<ItemRequestLateOrEarlyOnTab> createState() => _ItemRequestLateOrEarlyOnTabState();
}

class _ItemRequestLateOrEarlyOnTabState extends State<ItemRequestLateOrEarlyOnTab> {
  bool checkOpacity = false;

  Request requestById(List<Request> requests) {
    return requests.firstWhere((element) => element.id == widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, stateAttendance) {
        return BlocBuilder<RequestWorkSheetBloc, RequestWorkSheetState>(
          builder: (context, state) {
            final request = state.mapRequests[widget.id];
            return ContainerBorder(
                borderColors: colors.surfaceVariantHigh,
                child: Stack(
                  children: [
                    Opacity(
                      opacity: checkOpacity ? 1 : 0,
                      child: Center(
                        child: Lottie.asset(Assets.images.icon.loading,
                            width: SpacingUnit.x30, height: SpacingUnit.x30, fit: BoxFit.fill),
                      ),
                    ),
                    Opacity(
                      opacity: checkOpacity ? 0.5 : 1,
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
                                  callback: () => _nextScreenRequest(),
                                ),
                              )
                            ],
                          ),
                          TitleValueLeave(
                            title: checkType(request?.flowType)
                                ? appLocalizations.timeLate
                                : appLocalizations.timeEarly,
                            value: formatHMS(request?.config.startDate.toString() ?? ""),
                            size: SpacingUnit.x4,
                            padding: SpacingUnit.x3,
                          ),
                          TitleValueLeave(
                            title: appLocalizations.reason,
                            value: request?.config.description ?? "",
                            size: SpacingUnit.x4,
                            padding: SpacingUnit.x3,
                          ),
                          if (!checkType(request?.flowType))
                            TitleValueLeave(
                              title: appLocalizations.timeFrameOT,
                              value: setTotalOT(request?.config.overTimes, context),
                              size: SpacingUnit.x4,
                              padding: SpacingUnit.x3,
                            ),
                        ],
                      ),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(widget.dateTime) ?? false);
  }

  _nextScreenRequest() async {
    if (!checkOpacity) {
      setState(() {
        checkOpacity = true;
      });
      final Completer completer = Completer<RequisitionEnum>();
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      dI<RequisitionBloc>().add(
        GetRequisitionByIdEvent(id: widget.id, completer: completer),
      );
      final statusCompleter = await completer.future;
      if (statusCompleter == RequisitionEnum.success) {
        setState(() {
          checkOpacity = false;
        });
        if (!currentContext.mounted) return;
        dI<AppNavigation>().pushName(
          currentContext,
          page: Pages.requisitionInformationPage,
          extra: {
            'id': widget.id,
            'checkUser': false,
          },
        );
      }
    }
  }

  String setTotalOT(List<RequisitionOverTime>? overTimes, BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final listOT = overTimes ?? [];
    final index = listOT.indexWhere((element) => element.date == widget.dateTime);
    if (index != -1) {
      final startTime = listOT[index].startTime != null
          ? strSeconds(listOT[index].startTime!)
          : appLocalizations.forgotChecking;
      final endTime = listOT[index].startTime != null
          ? strSeconds(listOT[index].endTime!)
          : appLocalizations.forgotChecking;
      return '$startTime - $endTime';
    }
    return '';
  }

  bool checkType(RequisitionTypeEnum? flowType) {
    return flowType == RequisitionTypeEnum.lateArrival;
  }
}
