import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateReasonTransferType extends StatefulWidget {
  const ItemCreateReasonTransferType({super.key, this.onChange});

  final ValueChanged<RequisitionDeliveryTypeEnum>? onChange;

  @override
  State<ItemCreateReasonTransferType> createState() => _ItemCreateReasonTransferTypeState();
}

class _ItemCreateReasonTransferTypeState extends State<ItemCreateReasonTransferType> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.transferType,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: DropdownMenu<RequisitionDeliveryTypeEnum>(
            width: width * 0.8,
            textStyle: const TextStyle(fontSize: SpacingUnit.x4),
            initialSelection: RequisitionDeliveryTypeEnum.rush,
            onSelected: (RequisitionDeliveryTypeEnum? value) =>
                _onChangeReasonTransferType(value),
            menuHeight: SpacingUnit.x50,
            dropdownMenuEntries: RequisitionDeliveryTypeEnum.values
                .map(
                  (value) => DropdownMenuEntry<RequisitionDeliveryTypeEnum>(
                    value: value,
                    label: value.configDeliveryTypeName,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  _onChangeReasonTransferType(RequisitionDeliveryTypeEnum? value) {
    widget.onChange?.call(value ?? RequisitionDeliveryTypeEnum.rush);
  }
}
