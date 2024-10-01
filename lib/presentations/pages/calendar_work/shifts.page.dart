import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/toast_utils.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/shift_reason.widget.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/shifts_content.widget.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final shiftsPageRoute = GoRoute(
    path: Pages.shiftsPage,
    name: Pages.shiftsPage,
    builder: (context, GoRouterState state) {
      if (state.uri.hasQuery) {
        final query = state.uri.queryParameters;
        final data = ShiftsQueryParams.fromJson(query);
        return ShiftsPage(
          date: data.date,
          id: data.id,
        );
      }
      return const ErrorPage();
    });

class ShiftsPage extends StatefulWidget {
  const ShiftsPage({super.key, required this.date, required this.id});

  final DateTime date;
  final String id;

  @override
  State<ShiftsPage> createState() => _ShiftsPageState();
}

class _ShiftsPageState extends State<ShiftsPage> {
  final TextEditingController reasonController = TextEditingController();
  String errorDialog = '';

  _onBack() {
    Navigator.pop(context);
  }

  DateTime date(WorkDayState state) {
    final dateType =
        DateTime(widget.date.year, widget.date.month, widget.date.day);
    return dateType;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocConsumer<WorkDayBloc, WorkDayState>(
      listener: (context, state) => _listener(context, state.errorCode),
      builder: (context, state) {
        final index = state.workDays[date(state)]?.items.indexWhere(
                (element) => element.workShiftSettingDetailId == widget.id) ??
            0;
        final data = state.workDays[date(state)]?.items[index] ?? const Shift();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(SpacingUnit.x12),
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: SpacingUnit.x5,
                          right: SpacingUnit.x5,
                          bottom: SpacingUnit.x5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _onBack(),
                            child: Icon(
                              Icons.clear,
                              color: colors.text,
                              size: SpacingUnit.x7,
                            ),
                          ),
                          const SizedBox(width: SpacingUnit.x4),
                          Text(
                            appLocalizations.registerShift,
                            style: theme.textTheme.titleLarge!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
          body: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            child: Padding(
              padding: const EdgeInsets.all(SpacingUnit.x4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShiftsContentWidget(
                    data: data,
                  ),
                  if (data.status != WorkShiftRequestStatus.usable &&
                      data.status != WorkShiftRequestStatus.unusable &&
                      data.status != WorkShiftRequestStatus.pending)
                    ShiftReasonWidget(
                        reasonController: reasonController, data: data),
                  const Spacer(),
                  if (checkType(data.status))
                    AppButton(
                      colorText: Colors.white,
                      title: mapByStatus(
                          context: context, status: data.status)['titleButton'],
                      onSubmit: () {
                        if (data.status == WorkShiftRequestStatus.usable ||
                            data.status == WorkShiftRequestStatus.reject ||
                            data.status == WorkShiftRequestStatus.cancel) {
                          _register(
                            context: context,
                            map: state.workDays,
                            workDays: [
                              WorkDayRequest(
                                workShiftSettingDetailId:
                                    data.workShiftSettingDetailId,
                                workDate: formatYYMMDD(widget.date.toString()),
                              ),
                            ],
                            titlePopUp: mapByStatus(
                                context: context,
                                status: data.status)['success'],
                          );
                        } else {
                          onSubmit(
                            context: context,
                            status: data.status,
                            note: reasonController.text,
                            id: data.id,
                            map: state.workDays,
                            titlePopUp: mapByStatus(
                                context: context,
                                status: data.status)['success'],
                          );
                        }
                      },
                      color: mapByStatus(
                          context: context, status: data.status)['color'],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool checkType(WorkShiftRequestStatus status) {
    return
        // status != WorkShiftRequestStatus.cancel &&
        status != WorkShiftRequestStatus.remove &&
            status != WorkShiftRequestStatus.unusable;
  }

  Map<String, dynamic> mapByStatus({
    required BuildContext context,
    required WorkShiftRequestStatus status,
  }) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    switch (status) {
      case WorkShiftRequestStatus.pending:
        return {
          'color': colors.error,
          'titleButton': appLocalizations.cancelShiftReceiveRegistration,
          'success': appLocalizations.cancelShiftSuccess1,
        };
      case WorkShiftRequestStatus.approve:
        return {
          'color': colors.error,
          'titleButton': appLocalizations.cancelShift1,
          'success': appLocalizations.cancelShiftSuccess,
        };
      case WorkShiftRequestStatus.pendingCancel:
        return {
          'color': colors.error,
          'titleButton': appLocalizations.cancelShift2,
          'success': appLocalizations.cancelCancelShiftSuccess,
        };
      case WorkShiftRequestStatus.usable:
        return {
          'color': colors.blue,
          'titleButton': appLocalizations.registerForShifts,
          'success': appLocalizations.registeredShiftSuccessfully,
        };
      case WorkShiftRequestStatus.reject:
      case WorkShiftRequestStatus.cancel:
        return {
          'color': colors.blue,
          'titleButton': appLocalizations.registerForShifts,
          'success': appLocalizations.registeredShiftSuccessfully,
        };
      case WorkShiftRequestStatus.remove:
      case WorkShiftRequestStatus.unusable:
      default:
        return {};
    }
  }

  onSubmit({
    required BuildContext context,
    required String note,
    required String id,
    required WorkShiftRequestStatus status,
    required Map<DateTime, WorkDay> map,
    required String titlePopUp,
  }) async {
    if (reasonController.text.isNotEmpty ||
        status == WorkShiftRequestStatus.pending ||
        status == WorkShiftRequestStatus.pendingCancel) {
      Completer completer = Completer<bool>();
      dI<WorkDayBloc>().add(CancelRegisterWorkDay(
          completer: completer,
          data: CancelWorkDayRequest(note: note, id: id)));
      bool isCheck = await completer.future;
      if (isCheck) {
        dI<WorkDayBloc>().add(GetWorkDaysEvent(
            startDate: map.keys.first, endDate: map.keys.last));
        if (context.mounted) {
          Navigator.pop(context);
          dialogSuccess(context: context, title: titlePopUp, isPop: false);
        }
      }
    } else {
      ToastUtils().showError("Lý do không được bỏ trống");
    }
  }

  _listener(BuildContext context, String errorCode) {
    setState(() {
      errorDialog = errorCode.isNotEmpty
          ? ErrorUtils.getErrorMessage(errorCode, context: context)
          : "";
    });
  }

  _register({
    required List<WorkDayRequest> workDays,
    required BuildContext context,
    required Map<DateTime, WorkDay> map,
    required String titlePopUp,
  }) async {
    Completer completer = Completer<bool>();
    dI<WorkDayBloc>()
        .add(RegisterWorkDay(request: workDays, completer: completer));
    final check = await completer.future;
    if (check) {
      dI<WorkDayBloc>().add(
          GetWorkDaysEvent(startDate: map.keys.first, endDate: map.keys.last));
      if (context.mounted) {
        Navigator.pop(context);
        dialogSuccess(context: context, title: titlePopUp, isPop: false);
      }
    }
  }
}
