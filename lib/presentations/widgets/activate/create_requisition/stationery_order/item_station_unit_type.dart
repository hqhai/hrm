import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemStationeryUnitType extends StatefulWidget {
  const ItemStationeryUnitType({super.key, this.onChangeValue, this.title});

  final String? title;
  final ValueChanged<RequisitionStationeryUnitTypeEnum>? onChangeValue;

  @override
  State<ItemStationeryUnitType> createState() => _ItemStationeryUnitTypeState();
}

class _ItemStationeryUnitTypeState extends State<ItemStationeryUnitType> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title ?? "",
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        DropdownMenu<RequisitionStationeryUnitTypeEnum>(
          width: width * 0.5,
          textStyle: const TextStyle(fontSize: SpacingUnit.x3),
          initialSelection: RequisitionStationeryUnitTypeEnum.pairs,
          onSelected: (RequisitionStationeryUnitTypeEnum? value) => _setUnitType(value),
          menuHeight: SpacingUnit.x50,
          dropdownMenuEntries: RequisitionStationeryUnitTypeEnum.values
              .map(
                (value) => DropdownMenuEntry<RequisitionStationeryUnitTypeEnum>(
                  value: value,
                  label: value.configRequisitionStationeryUnitTypeName,
                ),
              )
              .toList(),
        ),
      ],
    );
  }

  _setUnitType(RequisitionStationeryUnitTypeEnum? value) {
    setState(() {
      if(value != null) {
        widget.onChangeValue?.call(value);
      }
    });
  }
}
