import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_delivery.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateReasonTransferType extends StatefulWidget {
  const ItemCreateReasonTransferType(
      {super.key, this.onChange, this.typeDefault});

  final RequisitionDeliveryTypeEnum? typeDefault;
  final ValueChanged<RequisitionDeliveryTypeEnum>? onChange;

  @override
  State<ItemCreateReasonTransferType> createState() =>
      _ItemCreateReasonTransferTypeState();
}

class _ItemCreateReasonTransferTypeState
    extends State<ItemCreateReasonTransferType> {
  RequisitionDeliveryTypeEnum type = RequisitionDeliveryTypeEnum.express;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            right: SpacingUnit.x4,
          ),
          child: Text(
            appLocalizations.transferType,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
            child: ContainerBorder(
              borderColors: colors.outline.withValues(alpha: 0.3),
              width: width,
              child: Text(
                type.configDeliveryTypeName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _onChangeReasonTransferType(RequisitionDeliveryTypeEnum value) {
    setState(() {
      type = value;
    });
    widget.onChange?.call(value);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDeliveryWidget(
          onChange: (value) => _onChangeReasonTransferType(value),
        );
      },
    );
  }
}
