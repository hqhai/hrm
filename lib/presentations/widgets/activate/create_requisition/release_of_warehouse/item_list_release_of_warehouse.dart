import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_title_value.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemListReleaseOfWarehouse extends StatefulWidget {
  const ItemListReleaseOfWarehouse(
      {super.key, this.requisitionReleaseOfWarehouse, this.index});

  final WarehouseReleaseds? requisitionReleaseOfWarehouse;
  final int? index;

  @override
  State<ItemListReleaseOfWarehouse> createState() =>
      _ItemListReleaseOfWarehouseState();
}

class _ItemListReleaseOfWarehouseState
    extends State<ItemListReleaseOfWarehouse> {
  bool checkType = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      children: [
        ContainerBorder(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemTitleValue(
                  title: appLocalizations.product,
                  value: widget.requisitionReleaseOfWarehouse?.product ?? ""),
              item(
                value:
                    '${appLocalizations.unit} : ${widget.requisitionReleaseOfWarehouse?.unit ?? ""}',
                color: colors.text,
              ),
              item(
                value:
                    '${appLocalizations.numberOf} : ${widget.requisitionReleaseOfWarehouse?.quantity}',
                color: colors.text,
              ),
            ],
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
