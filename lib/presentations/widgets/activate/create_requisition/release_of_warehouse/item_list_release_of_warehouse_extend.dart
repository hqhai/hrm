import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListReleaseOfWarehouseExtend extends StatelessWidget {
  const ItemListReleaseOfWarehouseExtend(
      {super.key, this.requisitionReleaseOfWarehouse, this.index});

  final WarehouseReleaseds? requisitionReleaseOfWarehouse;
  final int? index;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        Text(
          '${(index ?? 0) + 1}. ',
          style: TextStyle(
            fontSize: SpacingUnit.x5,
            color: colors.text,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: ContainerBorder(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                item(
                  value:
                  '${appLocalizations.product} : ${requisitionReleaseOfWarehouse?.product ?? ""}',
                  color: colors.text,
                ),
                item(
                  value: '${appLocalizations.unit} : ${requisitionReleaseOfWarehouse?.unit ?? ""}',
                  color: colors.text,
                ),
                item(
                  value:
                  '${appLocalizations.numberOf} : ${requisitionReleaseOfWarehouse?.quantity}',
                  color: colors.text,
                ),
                item(
                  value: '${appLocalizations.unit} : ${requisitionReleaseOfWarehouse?.unit ?? ""}',
                  color: colors.text,
                ),
                item(
                  value:
                  '${appLocalizations.description} : ${requisitionReleaseOfWarehouse?.explain}',
                  color: colors.text,
                ),
                item(
                  value:
                  '${appLocalizations.note} : ${requisitionReleaseOfWarehouse?.note}',
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
