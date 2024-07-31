import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateInput extends StatefulWidget {
  const ItemCreateInput({super.key, this.inputController, this.onChange, this.title, this.error});

  final TextEditingController? inputController;
  final ValueChanged<String>? onChange;
  final String? title, error;

  @override
  State<ItemCreateInput> createState() => _ItemCreateInputState();
}

class _ItemCreateInputState extends State<ItemCreateInput> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x2),
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
          padding: const EdgeInsets.only(top: SpacingUnit.x3),
          child: AppInput(
            placeHolder: widget.title ?? "",
            controller: widget.inputController,
            onChange: (value) => _onChangeInput(value),
          ),
        ),
        if (widget.error?.isNotEmpty??false)
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingUnit.x1),
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
