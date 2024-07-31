import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListOverTimeExtend extends StatelessWidget {
  const ItemListOverTimeExtend({super.key, this.requisitionOverTime, this.index});

  final RequisitionOverTime? requisitionOverTime;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Text(
          '${(index ?? 0) + 1}. ',
          style: TextStyle(
            fontSize: SpacingUnit.x3_5,
            color: colors.text,
          ),
        ),
        Container(
          width: width * 0.75,
          padding: const EdgeInsets.all(SpacingUnit.x2_5),
          margin: const EdgeInsets.only(left: SpacingUnit.x2_5, top: SpacingUnit.x4),
          decoration: BoxDecoration(
            color: colors.background,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
            border: Border.all(
              width: 1,
              color: colors.text,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                formatYMD((requisitionOverTime?.date ?? "").toString()),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: SpacingUnit.x3_5,
                  color: colors.text,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${appLocalizations.startTime} : ${strSeconds(requisitionOverTime?.startTime ?? 0)}',
                    style: TextStyle(
                      fontSize: SpacingUnit.x3,
                      color: colors.text,
                    ),
                  ),
                  Text(
                    '${appLocalizations.endTime} : ${strSeconds(requisitionOverTime?.endTime ?? 0)}',
                    style: TextStyle(
                      fontSize: SpacingUnit.x3,
                      color: colors.text,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.totalTime,
                    style: TextStyle(
                      fontSize: SpacingUnit.x3,
                      color: colors.text,
                    ),
                  ),
                  Text(
                    strSeconds((requisitionOverTime?.suggestTime ?? 0).toInt()),
                    style: TextStyle(
                      fontSize: SpacingUnit.x3,
                      color: colors.text,
                    ),
                  ),
                ],
              ),
              Row(crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      appLocalizations.note,
                      style: TextStyle(
                        fontSize: SpacingUnit.x3,
                        color: colors.text,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Text(
                        requisitionOverTime?.note ?? "",
                        //maxLines: 10,
                        //overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: SpacingUnit.x3,
                          color: colors.text,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
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
