import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/error_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/pages/calendar_work/widgets/reason_work_day_detail.dart';
import 'package:base_app/presentations/pages/error.page.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:common/utils/color_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

import '../../bloc/work_day/work_day_event.dart';

const List<WorkShiftRequestStatus> listStatus = [
  WorkShiftRequestStatus.usable,
  WorkShiftRequestStatus.pending,
  WorkShiftRequestStatus.approve,
  WorkShiftRequestStatus.cancel,
  WorkShiftRequestStatus.pendingCancel,
  WorkShiftRequestStatus.reject,
];

final shiftsPageReviewRoute = GoRoute(
    path: Pages.shiftsPageReview,
    name: Pages.shiftsPageReview,
    builder: (context, GoRouterState state) {
      if (state.uri.hasQuery) {
        final query = state.uri.queryParameters;
        final data = ShiftsReviewQueryParams.fromJson(query);
        return ShiftsPageReview(
          id: data.id,
          startTime: data.startTime,
          endTime: data.endTime,
        );
      }
      return const ErrorPage();
    });

class ShiftsPageReview extends StatefulWidget {
  final String id;
  final DateTime? startTime, endTime;

  const ShiftsPageReview({super.key, required this.id, this.startTime, this.endTime});

  @override
  State<ShiftsPageReview> createState() => _ShiftsPageReviewState();
}

class _ShiftsPageReviewState extends State<ShiftsPageReview> {
  final TextEditingController reasonController = TextEditingController();
  String errorDialog = '';
  String? errorTextField;

  _onBack() {
    Navigator.pop(context);
  }

  _onSubmit({
    required String note,
    required String id,
    required Map<DateTime, WorkDay> map,
    required WorkShiftRequestStatus status,
  }) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    if (status == WorkShiftRequestStatus.approve) {
      if (reasonController.text.trim().isNotEmpty) {
        Completer completerCancel = Completer();
        dI<WorkDayBloc>().add(CancelRegisterWorkDay(
          data: CancelWorkDayRequest(note: note, id: id),
          completer: completerCancel,
        ));
        final checkCancel = await completerCancel.future;
        if (checkCancel) {
          Completer completer = Completer();
          dI<WorkDayBloc>().add(
            GetWorkDayByUser(
              completer: completer,
              request: WorkDayGetElectiveShiftRequest(
                startDate: widget.startTime,
                endDate: widget.endTime,
              ),
            ),
          );
          final check = await completer.future;
          if (check) {
            if (!currentContext.mounted) return;
            _onBack();

            dialogSuccess(context: currentContext, title: mapByStatus(status: status, context: currentContext)['success'] ?? "", isPop: false);
          }
        }
      }
    } else {
      Completer completerCancel = Completer();
      dI<WorkDayBloc>().add(CancelRegisterWorkDay(
        data: CancelWorkDayRequest(note: note, id: id),
        completer: completerCancel,
      ));
      final checkCancel = await completerCancel.future;
      if (checkCancel) {
        Completer completer = Completer();
        dI<WorkDayBloc>().add(
          GetWorkDayByUser(
            completer: completer,
            request: WorkDayGetElectiveShiftRequest(
              startDate: widget.startTime,
              endDate: widget.endTime,
            ),
          ),
        );
        final check = await completer.future;
        if (check) {
          if (!currentContext.mounted) return;
          _onBack();
          dialogSuccess(context: currentContext, title: mapByStatus(status: status, context: currentContext)['success'] ?? "", isPop: false);
        }
      }
    }
  }

  _listener(BuildContext context, String errorCode) {
    setState(() {
      errorDialog = errorCode.isNotEmpty ? ErrorUtils.getErrorMessage(errorCode, context: context) : "";
    });
  }

  _register({required List<WorkDayRequest> workDays, required BuildContext context, required Map<DateTime, WorkDay> map}) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    Completer completer = Completer<bool>();
    dI<WorkDayBloc>().add(RegisterWorkDay(request: workDays, completer: completer));
    final check = await completer.future;
    if (check) {
      /*DateTime startTime = getFirstDayOfMonth(DateTime.now()),
          endTime = getLastDayOfMonth(DateTime.now());*/
      Completer completerGetWorkDay = Completer<bool>();
      dI<WorkDayBloc>().add(
        GetWorkDayByUser(
          completer: completerGetWorkDay,
          request: WorkDayGetElectiveShiftRequest(
            startDate: widget.startTime,
            endDate: widget.endTime,
          ),
        ),
      );
      final checkGetWorkDay = await completerGetWorkDay.future;
      if (checkGetWorkDay) {
        if (!currentContext.mounted) return;
        _onBack();
        dialogSuccess(context: currentContext, title: mapByStatus(status: WorkShiftRequestStatus.usable, context: currentContext)['success'] ?? "", isPop: false);
      }
    }
    dI<WorkDayBloc>().add(const ChangeLoading(status: true));
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocConsumer<WorkDayBloc, WorkDayState>(
      listener: (context, state) => _listener(context, state.errorCode),
      builder: (context, state) {
        final data = state.items.singleWhere((element) => element.id == widget.id);
        int index = listStatus.indexWhere((item) => item == data.status);
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
                        bottom: SpacingUnit.x5,
                      ),
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
                            appLocalizations.shiftDetails,
                            style: theme.textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ShiftsContentWidget(
                          data: data,
                        ),
                        data.status == WorkShiftRequestStatus.approve || data.status == WorkShiftRequestStatus.cancel || data.status == WorkShiftRequestStatus.reject
                            ? ReasonWorkDayDetail(
                                reasonController: reasonController,
                                data: data.workShiftApproves.isNotEmpty ? data.workShiftApproves.first.content : '',
                                status: data.status,
                                errorTextField: errorTextField,
                              )
                            : const SizedBox(),
                        const SizedBox(height: SpacingUnit.x1),
                        Divider(
                          color: colors.textTertiary,
                          height: SpacingUnit.x0_25,
                        ),
                        const SizedBox(height: SpacingUnit.x1),
                        Text(
                          appLocalizations.shiftHistory,
                          style: theme.textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: SpacingUnit.x2),
                        _Item(listStatus[0], index),
                        const _ItemLine(),
                        _Item(listStatus[1], index),
                        const _ItemLine(),
                        _Item(listStatus[2], index),
                        const _ItemLine(),
                        _Item(listStatus[3], index),
                        const _ItemLine(),
                        _Item(listStatus[4], index),
                        const _ItemLine(),
                        _Item(listStatus[5], index),
                      ],
                    ),
                  ),
                ),
                if (checkType(data.status))
                  Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    child: AppButton(
                      colorText: Colors.white,
                      title: mapByStatus(context: context, status: data.status)['titleButton'] ?? "",
                      onSubmit: () {
                        if (reasonController.text.trim().isEmpty) {
                          setState(() {
                            errorTextField = appLocalizations.cannotBeLeftBlank;
                          });
                        }
                        if (data.status == WorkShiftRequestStatus.cancel || data.status == WorkShiftRequestStatus.reject || data.status == WorkShiftRequestStatus.usable) {
                          _register(context: context, map: state.workDays, workDays: [
                            WorkDayRequest(
                              workShiftSettingDetailId: data.workShiftSettingDetailId,
                              workDate: formatYYMMDD(data.workDate.toString()),
                            )
                          ]);
                        } else {
                          _onSubmit(
                            note: reasonController.text,
                            id: data.id,
                            map: state.workDays,
                            status: data.status,
                          );
                        }
                      },
                      color: mapByStatus(context: context, status: data.status)['color'],
                    ),
                  ),
                // if (checkType(data?.status ?? WorkShiftRequestStatus.usable))
                //   ShiftReasonWidget(reasonController: reasonController),
              ],
            ),
          ),
        );
      },
    );
  }

  bool checkType(WorkShiftRequestStatus status) {
    return status != WorkShiftRequestStatus.remove && status != WorkShiftRequestStatus.unusable;
  }
}

class _ShiftsContentWidget extends StatelessWidget {
  const _ShiftsContentWidget({required this.data});

  final WorkDayAdmin data;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: SpacingUnit.x2),
          child: Text(
            '${nameWeekDay(data.workDate)}, ${dayMonthYear(
              time: data.workDate,
              context: context,
            )}',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: SpacingUnit.x4,
              color: colors.text,
            ),
          ),
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.shiftCode,
          value: data.code,
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.shiftName,
          value: data.name,
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.workingTime1,
          value: '${strSeconds(data.startTime) ?? ''} - ${strSeconds(data.endTime) ?? ''}',
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.recordedNumberOfShifts,
          value: data.workEffort.toString(),
        ),
        _TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.validTimeKeeping,
          value: '${strSeconds(data.checkInStartTimeValid) ?? ''} - ${strSeconds(data.checkOutEndTimeValid) ?? ''}',
        ),
      ],
    );
  }
}

class _TitleValueLeave extends StatelessWidget {
  const _TitleValueLeave({
    required this.title,
    required this.value,
    this.size = SpacingUnit.x3,
    this.font = FontWeight.normal,
    this.padding = 0,
  });

  final String title, value;
  final double size, padding;
  final FontWeight font;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              color: colors.text,
              fontSize: size,
              fontWeight: font,
            ),
          ),
          const SizedBox(width: SpacingUnit.x2),
          Text(
            value,
            style: TextStyle(
              color: colors.text,
              fontSize: size,
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final WorkShiftRequestStatus status;
  final int index;

  const _Item(this.status, this.index);

  @override
  Widget build(BuildContext context) {
    final int statusIndex = listStatus.indexWhere((element) => element == status);
    final isCheck = index < statusIndex;
    return Row(
      children: [
        Icon(Icons.radio_button_checked, color: isCheck ? ColorUtils.parseHex("#B2B7BC") : setColor(context: context, status: status)),
        const SizedBox(width: SpacingUnit.x2),
        Text(
          status.configWorkShiftRequestStatusName,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: SpacingUnit.x4,
            color: isCheck ? ColorUtils.parseHex("#B2B7BC") : setColor(context: context, status: status),
          ),
        ),
      ],
    );
  }
}

class _ItemLine extends StatelessWidget {
  const _ItemLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: SpacingUnit.x2_5, top: SpacingUnit.x1, bottom: SpacingUnit.x1),
      width: SpacingUnit.x0_5,
      height: SpacingUnit.x6,
      color: ColorUtils.parseHex("#B2B7BC"),
    );
  }
}

Color setColor({
  required BuildContext context,
  required WorkShiftRequestStatus status,
}) {
  final colors = AppTheme.getColors(context);
  switch (status) {
    case WorkShiftRequestStatus.pending:
      return colors.goldenPurple;
    case WorkShiftRequestStatus.approve:
      return colors.success;
    case WorkShiftRequestStatus.reject:
      return colors.surfaceTint;
    case WorkShiftRequestStatus.pendingCancel:
      return colors.orange;
    case WorkShiftRequestStatus.cancel:
      return colors.error;
    case WorkShiftRequestStatus.remove:
      return ColorUtils.parseHex("#808890");
    case WorkShiftRequestStatus.usable:
      return colors.blue;
    case WorkShiftRequestStatus.unusable:
      return colors.shadow;
    default:
      return Colors.transparent;
  }
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
      return {
        'color': ColorUtils.parseHex('#2F6BFF'),
        'titleButton': appLocalizations.registerForShifts,
      };
    case WorkShiftRequestStatus.cancel:
      return {
        'color': ColorUtils.parseHex('#2F6BFF'),
        'titleButton': appLocalizations.registerForShifts,
        'success': appLocalizations.registeredShiftSuccessfully,
      };
    case WorkShiftRequestStatus.remove:
    case WorkShiftRequestStatus.unusable:
    default:
      return {};
  }
}
