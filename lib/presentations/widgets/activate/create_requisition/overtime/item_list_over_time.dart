import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListOverTime extends StatelessWidget {
  const ItemListOverTime({super.key, required this.requisitionOverTime, required this.index});

  final RequisitionOverTime requisitionOverTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${(index) + 1}. ',
          style:
              TextStyle(fontSize: SpacingUnit.x5, color: colors.text, fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: ContainerBorder(
            padding: SpacingUnit.x2_5,
            margin: SpacingUnit.x2_5,
            borderColors: colors.text.withOpacity(0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                  child: Text(
                    '${appLocalizations.date} ${formatYMD((requisitionOverTime.date ?? "").toString())}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: SpacingUnit.x3_5,
                      color: colors.text,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                  child: Text(
                    '${appLocalizations.time} : ${strSeconds(requisitionOverTime.startTime ?? 0)} - ${strSeconds(requisitionOverTime.endTime ?? 0)}',
                    style: TextStyle(
                      fontSize: SpacingUnit.x3_5,
                      color: colors.text,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String strSeconds(int time) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return formatHM(result.toString());
  }
}
