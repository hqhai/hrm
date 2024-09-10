import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ItemAddStationeryDialog extends StatefulWidget {
  const ItemAddStationeryDialog(
      {super.key,
      this.check = true,
      this.productController,
      this.unitController,
      this.unitPriceController,
      required this.onChangeProduct,
      required this.onchangeUnit,
      this.onChangeUnitPrice,
      required this.callBack,
      required this.type});

  final VoidCallback callBack;
  final ValueChanged<String> onChangeProduct, onchangeUnit;
  final ValueChanged<double>? onChangeUnitPrice;
  final TextEditingController? productController, unitController, unitPriceController;
  final bool check;
  final RequisitionTypeEnum type;

  @override
  State<ItemAddStationeryDialog> createState() => _ItemAddStationeryDialogState();
}

class _ItemAddStationeryDialogState extends State<ItemAddStationeryDialog> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: widget.type == RequisitionTypeEnum.stationery
              ? AppInput(
                  inputFormatter: [LengthLimitingTextInputFormatter(50)],
                  onClickIcon: () => widget.callBack.call(),
                  icon: Icons.arrow_drop_down_sharp,
                  placeHolder: appLocalizations.product,
                  controller: widget.productController,
                  onChange: (value) => setProduct(value),
                  error: widget.productController?.text.isNotEmpty ?? false
                      ? ''
                      : appLocalizations.cannotBeLeftBlank,
                )
              : AppInput(
                  inputFormatter: [LengthLimitingTextInputFormatter(50)],
                  placeHolder: appLocalizations.product,
                  controller: widget.productController,
                  onChange: (value) => setProduct(value),
                  error: widget.productController?.text.isNotEmpty ?? false
                      ? ''
                      : appLocalizations.cannotBeLeftBlank,
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: TitleRequired(
            title: appLocalizations.unit,
            requiredValidate: true,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: AppInput(
            inputFormatter: [LengthLimitingTextInputFormatter(50)],
            placeHolder: appLocalizations.unit,
            controller: widget.unitController,
            onChange: (value) => setUnit(value),
            error: widget.unitController?.text.isNotEmpty ?? false
                ? ''
                : appLocalizations.cannotBeLeftBlank,
          ),
        ),
        if (widget.check) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            child: TitleRequired(
              title: appLocalizations.unitPrice,
              requiredValidate: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            child: AppInput(
              keyboardType: TextInputType.number,
              controller: widget.unitPriceController,
              onChange: (value) => setUnitPrice(value),
              error: widget.unitPriceController?.text.isNotEmpty ?? false
                  ? ''
                  : appLocalizations.cannotBeLeftBlank,
            ),
          ),
        ]
      ],
    );
  }

  setProduct(String value) {
    widget.onChangeProduct.call(value);
  }

  setUnit(String value) {
    widget.onchangeUnit.call(value);
  }

  setUnitPrice(String value) {
    if (value.isNotEmpty) {
      final double price = double.parse(value);
      widget.onChangeUnitPrice?.call(price);
    } else {
      widget.onChangeUnitPrice?.call(0);
    }
  }

// '${(widget.unitPrice ?? 0).toInt()}',
}
