import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListOverTimeExtend extends StatelessWidget {
  const ItemListOverTimeExtend(
      {super.key, this.requisitionOverTime, required this.index});

  final RequisitionOverTime? requisitionOverTime;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(
          '${index + 1}. ',
          style: TextStyle(
              fontSize: SpacingUnit.x5,
              color: colors.text,
              fontWeight: FontWeight.w600),
        ),
        Expanded(
          child: ContainerBorder(
            paddingVertical: SpacingUnit.x2_5,
            marginTop: SpacingUnit.x2_5,
            borderColors: colors.text.withValues(alpha: 0.5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                  child: Text(
                    '${appLocalizations.date} : ${formatYMD((requisitionOverTime?.date ?? "").toString())}',
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${appLocalizations.startTime} : ${strSeconds(requisitionOverTime?.startTime ?? 0)}',
                        style: TextStyle(
                          fontSize: SpacingUnit.x3_5,
                          color: colors.text,
                        ),
                      ),
                      Text(
                        '${appLocalizations.endTime} : ${strSeconds(requisitionOverTime?.endTime ?? 0)}',
                        style: TextStyle(
                          fontSize: SpacingUnit.x3_5,
                          color: colors.text,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.totalTimeWork,
                        style: TextStyle(
                          fontSize: SpacingUnit.x3_5,
                          color: colors.text,
                        ),
                      ),
                      Text(
                        strSeconds(
                            (requisitionOverTime?.suggestTime ?? 0).toInt()),
                        style: TextStyle(
                          fontSize: SpacingUnit.x3_5,
                          color: colors.text,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${appLocalizations.note} : ',
                      style: TextStyle(
                        fontSize: SpacingUnit.x3_5,
                        color: colors.text,
                      ),
                    ),
                    Text(
                      '   ${requisitionOverTime?.note ?? ""}',
                      style: TextStyle(
                        fontSize: SpacingUnit.x3_5,
                        color: colors.text,
                      ),
                    ),
                  ],
                )
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
