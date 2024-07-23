import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/ahift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/ahift/shift_state.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/shift_reason.widget.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/shifts_content.widget.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final shiftsPageRoute = GoRoute(
    path: Pages.shiftsPage,
    name: Pages.shiftsPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return ShiftsPage(
        id: data['id'],
      );
    });

class ShiftsPage extends StatefulWidget {
  const ShiftsPage({super.key, required this.id});

  final String id;

  @override
  State<ShiftsPage> createState() => _ShiftsPageState();
}

class _ShiftsPageState extends State<ShiftsPage> {
  final TextEditingController reasonController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(),
          body: ContainerScreenMain(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShiftsContentWidget(
                  id: widget.id,
                ),
                ShiftReasonWidget(reasonController: reasonController),
                const Spacer(),
                if (checkType(state.shift.status))
                  AppButton(
                    title:
                    mapByStatus(context: context, status: state.shift.status)['titleButton'],
                    onSubmit: () => onSubmit(),
                    color: mapByStatus(context: context, status: state.shift.status)['color'],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool checkType(WorkShiftRequestStatus status) {
    return status != WorkShiftRequestStatus.reject &&
        status != WorkShiftRequestStatus.cancel &&
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
        };
      case WorkShiftRequestStatus.approve:
        return {
          'color': colors.error,
          'titleButton': appLocalizations.cancelShiftCancellationRequest,
        };
      case WorkShiftRequestStatus.pendingCancel:
        return {
          'color': colors.error,
          'titleButton': appLocalizations.cancelShiftCancellationRequest,
        };
      case WorkShiftRequestStatus.usable:
        return {
          'color': colors.blue,
          'titleButton': appLocalizations.registerForShifts,
        };
      case WorkShiftRequestStatus.reject:
      case WorkShiftRequestStatus.cancel:
      case WorkShiftRequestStatus.remove:
      case WorkShiftRequestStatus.unusable:
        return {};
    }
  }

  onSubmit() {}
}
