import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListStationeries extends StatelessWidget {
  const ItemListStationeries({super.key, this.stationeries, this.index});

  final Stationeries? stationeries;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
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
          height: height * 0.1,
          width: width * 0.75,
          padding: const EdgeInsets.all(SpacingUnit.x2_5),
          margin: const EdgeInsets.only(left: SpacingUnit.x2_5, top: SpacingUnit.x4),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
            border: Border.all(
              width: 1,
              color: colors.text,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                stationeries?.product ?? "",
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
                    '${appLocalizations.unit} : ${stationeries?.unit??""}',
                    style: TextStyle(
                      fontSize: SpacingUnit.x3,
                      color: colors.text,
                    ),
                  ),
                  Text(
                    '${appLocalizations.numberOf} : ${stationeries?.quantity}',
                    style: TextStyle(
                      fontSize: SpacingUnit.x3,
                      color: colors.text,
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
}
