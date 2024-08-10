import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ShiftWidget extends StatelessWidget {
  const ShiftWidget(
      {super.key, required this.context, required this.title, required this.workShift});

  final BuildContext context;
  final String title;
  final WorkShiftRegisteredDetail workShift;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return ContainerBorder(
      borderColors: colors.text.withOpacity(0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title.isNotEmpty)
          Text(
            title,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w600,
            ),
          ),
          ItemTitleValueNoBorder(
            size: SpacingUnit.x4,
            title: appLocalizations.date,
            value: formatYMD(workShift.workDate.toString()),
          ),
          ItemTitleValueNoBorder(
            size: SpacingUnit.x4,
            title: appLocalizations.shift,
            value:
                '${strSeconds(workShift.startTime) ?? ""} - ${strSeconds(workShift.endTime) ?? ""}',
          ),
        ],
      ),
    );
  }
}
