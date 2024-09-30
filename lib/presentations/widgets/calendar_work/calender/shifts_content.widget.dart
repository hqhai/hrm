import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themes/themes.dart';

class ShiftsContentWidget extends StatelessWidget {
  const ShiftsContentWidget({super.key, required this.data});

  final Shift data;

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
        TitleValueLeave(
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.timeWorking,
          value: data.name,
        ),
        TitleValueLeave(
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.code,
          value: data.code,
        ),
        TitleValueLeave(
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.time,
          value: '${strSeconds(data.startTime) ?? ''} - ${strSeconds(data.endTime) ?? ''}',
        ),
        TitleValueLeave(
          padding: SpacingUnit.x2,
          font: FontWeight.w700,
          title: appLocalizations.validTimeKeeping,
          value:
              '${strSeconds(data.checkInEndTimeValid) ?? ''} - ${strSeconds(data.checkOutEndTimeValid) ?? ''}',
        ),
        /*if (data.status == WorkShiftRequestStatus.reject ||
            data.status == WorkShiftRequestStatus.cancel ||
            data.status == WorkShiftRequestStatus.pendingCancel)
          TitleValueLeave(
            padding: SpacingUnit.x2,
            font: FontWeight.w700,
            title: appLocalizations.reasonForCancellation,
            value: data.workShiftApproves.isNotEmpty ? data.workShiftApproves.first.content : '',
          ),*/
        Divider(
          color: colors.textTertiary,
          height: SpacingUnit.x0_25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SpacingUnit.x2,
          ),
          child: Row(
            children: [
              if (checkType(data.status))
                SvgPicture.asset(
                  _setIcon(status: data.status),
                  colorFilter: ColorFilter.mode(
                      setColor(
                        context: context,
                        status: data.status,
                      ),
                      BlendMode.srcIn),
                ),
              const SizedBox(
                width: SpacingUnit.x2,
              ),
              Text(
                data.status.configWorkShiftRequestStatusName,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: SpacingUnit.x4,
                  color: setColor(
                    context: context,
                    status: data.status,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
        return colors.shadow;
      case WorkShiftRequestStatus.usable:
        return colors.blue;
      case WorkShiftRequestStatus.unusable:
        return colors.shadow;
      default:
        return Colors.transparent;
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
      default:
        return '';
    }
  }
}
