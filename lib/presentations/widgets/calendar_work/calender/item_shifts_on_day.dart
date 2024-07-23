import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemShiftsOnDay extends StatelessWidget {
  const ItemShiftsOnDay({super.key, required this.shift});

  final Shift shift;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final colors = AppTheme.getColors(context);
    return Container(
      margin: const EdgeInsets.all(SpacingUnit.x2),
      padding: const EdgeInsets.all(SpacingUnit.x2),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color: setColor(context),
        border: Border.all(
          color: setColor(context),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${formatYMD(shift.startTime.toString())} - ${formatYMD(shift.endTime.toString())}',
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x3,
            ),
          ),
          if (checkType())
            Row(
              children: [
                SvgPicture.asset(
                  _setIcon(shift.status),
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
                Text(
                  shift.status.configWorkShiftRequestStatusName,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Color setColor(BuildContext context) {
    final colors = AppTheme.getColors(context);
    switch (shift.status) {
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

  bool checkType() {
    return shift.status != WorkShiftRequestStatus.usable;
  }

  String _setIcon(WorkShiftRequestStatus status) {
    switch (shift.status) {
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
