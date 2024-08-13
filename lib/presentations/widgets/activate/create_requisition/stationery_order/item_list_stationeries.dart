import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListStationeries extends StatelessWidget {
  const ItemListStationeries(
      {super.key, this.stationeries, required this.index});

  final Stationeries? stationeries;
  final int index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(
          '${(index) + 1}. ',
          style: TextStyle(
            fontSize: SpacingUnit.x5,
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: ContainerBorder(
            paddingVertical: SpacingUnit.x2_5,
            marginTop: SpacingUnit.x2_5,
            borderColors: colors.text.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item(
                  value: stationeries?.product ?? "",
                  color: colors.text,
                ),
                item(
                  value:
                      '${appLocalizations.unit} : ${stationeries?.unit ?? ""}',
                  color: colors.text,
                ),
                item(
                  value:
                      '${appLocalizations.numberOf} : ${stationeries?.quantity}',
                  color: colors.text,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget item({required String value, required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x2),
      child: Text(
        value,
        style: TextStyle(
          fontSize: SpacingUnit.x3_5,
          color: color,
        ),
      ),
    );
  }
}
