import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:themes/themes.dart';

class ItemCreateInput extends StatefulWidget {
  const ItemCreateInput(
      {super.key,
      this.inputController,
      this.onChange,
      this.title,
      this.error,
      this.subTitle,
      this.requiredValidate = false,
      this.textInputFormatter});

  final TextEditingController? inputController;
  final ValueChanged<String>? onChange;
  final String? title, error, subTitle;
  final bool requiredValidate;
  final List<TextInputFormatter>? textInputFormatter;

  @override
  State<ItemCreateInput> createState() => _ItemCreateInputState();
}

class _ItemCreateInputState extends State<ItemCreateInput> {
  String strValue = '';

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x2),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: widget.title,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (widget.requiredValidate)
                  TextSpan(
                    text: "*",
                    style: TextStyle(
                      color: colors.error,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                TextSpan(
                  text: widget.subTitle ?? "",
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x3),
          child: AppInputArea(
            inputFormatter: widget.textInputFormatter ??
                [
                  LengthLimitingTextInputFormatter(255),
                ],
            maxLines: 4,
            error: strValue.isNotEmpty ? '' : widget.error,
            placeHolder: widget.title ?? "",
            controller: widget.inputController,
            onChange: (value) => _onChangeInput(value),
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4,
        ),
      ],
    );
  }

  _onChangeInput(String value) {
    setState(() {
      strValue = value;
      widget.onChange?.call(value);
    });
  }
}
