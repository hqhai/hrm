import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themes/themes.dart';

class ItemMonthInput extends StatefulWidget {
  const ItemMonthInput({super.key, this.inputController, this.onChange, this.title, this.error});

  final TextEditingController? inputController;
  final ValueChanged<String>? onChange;
  final String? title, error;

  @override
  State<ItemMonthInput> createState() => _ItemMonthInputState();
}

class _ItemMonthInputState extends State<ItemMonthInput> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x3),
          child: Text(
            widget.title ?? "",
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: AppInput(
            placeHolder: widget.title ?? "",
            controller: widget.inputController,
            inputFormatter: [
              FilteringTextInputFormatter.allow(
                RegExp(monthOfRegexExp),
              ),
            ],
            onChange: (value) => _onChangeInput(value),
          ),
        ),
        if (widget.error?.isNotEmpty??false)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
            child: Text(
              widget.error ?? "",
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
      ],
    );
  }

  _onChangeInput(String value) {
    widget.onChange?.call(value);
  }
}
