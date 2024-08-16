import 'package:base_app/common/utils/regex_exp.dart';
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
      required this.callBack});

  final VoidCallback callBack;
  final ValueChanged<String> onChangeProduct, onchangeUnit;
  final ValueChanged<double>? onChangeUnitPrice;
  final TextEditingController? productController, unitController, unitPriceController;
  final bool check;

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
          child: AppInput(
            onClickIcon: () => widget.callBack.call(),
            icon: Icons.arrow_drop_down_sharp,
            placeHolder: appLocalizations.product,
            controller: widget.productController,
            onChange: (value) => setProduct(value),
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
            placeHolder: appLocalizations.unit,
            controller: widget.unitController,
            onChange: (value) => setUnit(value),
          ),
        ),
        if (widget.check)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            child: TitleRequired(
              title: appLocalizations.unitPrice,
              requiredValidate: true,
            ),
          ),
        if (widget.check)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
            child: AppInput(
              inputFormatter: [
                FilteringTextInputFormatter.allow(
                  RegExp(numberRegexExp),
                ),
              ],
              controller: widget.unitPriceController,
              onChange: (value) => setUnitPrice(value),
            ),
          ),
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
    final double price = double.parse(value);
    widget.onChangeUnitPrice?.call(price);
  }

// '${(widget.unitPrice ?? 0).toInt()}',
}
