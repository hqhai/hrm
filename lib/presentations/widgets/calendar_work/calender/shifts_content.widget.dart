import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/ahift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/ahift/shift_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themes/themes.dart';

class ShiftsWidget extends StatelessWidget {
  const ShiftsWidget({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ShiftBloc, ShiftState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              '${nameWeekDay(state.shift.workDate)}, ${dayMonthYear(
                time: state.shift.workDate,
                context: context,
              )}',
              style: TextStyle(
                fontSize: SpacingUnit.x4,
                color: colors.text,
              ),
            ),
            ItemTitleValue(
              title: appLocalizations.timeWorking,
              value: strSeconds(state.shift.endTime - state.shift.endTime) ?? '',
            ),
            ItemTitleValue(
              title: appLocalizations.code,
              value: state.shift.code,
            ),
            ItemTitleValue(
              title: appLocalizations.time,
              value:
                  '${strSeconds(state.shift.endTime) ?? ''} - ${strSeconds(state.shift.startTime) ?? ''}',
            ),
            ItemTitleValue(
              title: appLocalizations.code,
              value: state.shift.code,
            ),
            Divider(
              color: colors.tertiary,
              height: SpacingUnit.x0_25,
            ),
            Row(
              children: [
                SvgPicture.asset(
                  _setIcon(status: state.shift.status),
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
                Text(
                  state.shift.status.configWorkShiftRequestStatusName,
                  style: TextStyle(
                    fontSize: SpacingUnit.x4,
                    color: setColor(context: context, status: state.shift.status),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Color setColor({
    required BuildContext context,
    required WorkShiftRequestStatus status,
  }) {
    final colors = AppTheme.getColors(context);
    switch (status) {
      case WorkShiftRequestStatus.pending:
        return colors.error.withOpacity(0.16);
      case WorkShiftRequestStatus.approve:
        return colors.success;
      case WorkShiftRequestStatus.reject:
        return colors.surfaceTint;
      case WorkShiftRequestStatus.pendingCancel:
        return colors.orange;
      case WorkShiftRequestStatus.cancel:
        return colors.error;
      case WorkShiftRequestStatus.remove:
        return colors.shadow;
      case WorkShiftRequestStatus.usable:
        return colors.blue;
      case WorkShiftRequestStatus.unusable:
        return colors.shadow;
    }
  }

  bool checkType(WorkShiftRequestStatus status) {
    return status != WorkShiftRequestStatus.usable;
  }

  String _setIcon({required WorkShiftRequestStatus status}) {
    switch (status) {
      case WorkShiftRequestStatus.pending:
        return Assets.images.icon.work.loading;
      case WorkShiftRequestStatus.approve:
        return Assets.images.icon.work.success;
      case WorkShiftRequestStatus.reject:
        return Assets.images.icon.work.reject;
      case WorkShiftRequestStatus.pendingCancel:
        return Assets.images.icon.work.loading;
      case WorkShiftRequestStatus.cancel:
        return Assets.images.icon.work.reject;
      case WorkShiftRequestStatus.remove:
        return Assets.images.icon.work.reject;
      case WorkShiftRequestStatus.usable:
        return Assets.images.icon.work.success;
      case WorkShiftRequestStatus.unusable:
        return Assets.images.icon.work.reject;
    }
  }
}
