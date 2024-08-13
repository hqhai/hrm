import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/stationeries.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemListStationeriesExtend extends StatefulWidget {
  const ItemListStationeriesExtend(
      {super.key, this.stationeries, required this.index});

  final Stationeries? stationeries;
  final int index;

  @override
  State<ItemListStationeriesExtend> createState() =>
      _ItemListStationeriesExtendState();
}

class _ItemListStationeriesExtendState
    extends State<ItemListStationeriesExtend> {
  bool checkType = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return ContainerBorder(
      width: width,
      paddingVertical: SpacingUnit.x2_5,
      marginTop: SpacingUnit.x2_5,
      borderColors: colors.text.withOpacity(0.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: SpacingUnit.x1,
                top: SpacingUnit.x2,
                bottom: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.stationeries?.product ?? appLocalizations.product,
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
              value: widget.stationeries?.unit ?? "",
            ),
          if (checkType)
            ItemTitleValueNoBorder(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.numberOf,
              value: (widget.stationeries?.quantity ?? 0).toString(),
            ),
          if (checkType)
            ItemTitleValueNoBorder(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.unitPrice,
              value: (widget.stationeries?.unitPrice ?? 0).toString(),
            ),
          if (checkType)
            ItemTitleValueNoBorder(
              font: FontWeight.w500,
              size: SpacingUnit.x4,
              title: appLocalizations.intoMoney,
              value: (widget.stationeries?.amount ?? 0).toString(),
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
