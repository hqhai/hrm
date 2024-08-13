import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/warehouse_releaseds.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border_colum.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemListReleaseOfWarehouseExtend extends StatefulWidget {
  const ItemListReleaseOfWarehouseExtend(
      {super.key, this.requisitionReleaseOfWarehouse, this.index});

  final WarehouseReleaseds? requisitionReleaseOfWarehouse;
  final int? index;

  @override
  State<ItemListReleaseOfWarehouseExtend> createState() => _ItemListReleaseOfWarehouseExtendState();
}

class _ItemListReleaseOfWarehouseExtendState extends State<ItemListReleaseOfWarehouseExtend> {
  bool checkType = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return ContainerBorder(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.requisitionReleaseOfWarehouse?.product ?? appLocalizations.product,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => setShowFull(),
                  child: SvgPicture.asset(
                    width: SpacingUnit.x8,
                    height: SpacingUnit.x8,
                    checkType
                        ? Assets.images.icon.home.chevronForward
                        : Assets.images.icon.activateIcon.drop,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          if (checkType)
            ItemTitleValueNoBorder(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.unit,
              value: widget.requisitionReleaseOfWarehouse?.unit ?? "",
            ),
          if (checkType)
            ItemTitleValueNoBorder(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.numberOf,
              value: (widget.requisitionReleaseOfWarehouse?.quantity ?? 0).toString(),
            ),
          if (checkType)
            ItemTitleValueNoBorderColum(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.explain,
              value: widget.requisitionReleaseOfWarehouse?.explain ?? "",
            ),
          if (checkType)
            ItemTitleValueNoBorderColum(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.note,
              value: widget.requisitionReleaseOfWarehouse?.note ?? "",
            ),
        ],
      ),
    );
  }

  setShowFull() {
    setState(() {
      checkType = !checkType;
    });
  }
}
