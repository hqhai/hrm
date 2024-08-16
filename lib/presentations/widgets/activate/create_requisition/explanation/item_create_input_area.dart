import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateInputArea extends StatefulWidget {
  const ItemCreateInputArea(
      {super.key,
      this.textController,
      this.onChange,
      this.title = '',
      this.error = '',
      this.maxLines,
      this.fontWeightTitle,
      this.requiredValidate = false});

  final String title;
  final String? error;
  final int? maxLines;
  final TextEditingController? textController;
  final ValueChanged<String>? onChange;
  final FontWeight? fontWeightTitle;
  final bool requiredValidate;

  @override
  State<ItemCreateInputArea> createState() => _ItemCreateInputAreaState();
}

class _ItemCreateInputAreaState extends State<ItemCreateInputArea> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleRequired(title: widget.title, requiredValidate: widget.requiredValidate),
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x2),
          child: AppInputArea(
            maxLines: widget.maxLines ?? 4,
            placeHolder: widget.title,
            controller: widget.textController,
            onChange: (value) => _setOnChangeText(value),
          ),
        ),
        if (widget.error?.isNotEmpty ?? false)
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

  _setOnChangeText(String value) {
    widget.onChange?.call(value);
  }
}
