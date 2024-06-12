import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateInputArea extends StatefulWidget {
  const ItemCreateInputArea(
      {super.key, this.textController, this.onChange, this.title = '', this.error = ''});

  final String title;
  final String? error;
  final TextEditingController? textController;
  final ValueChanged<String>? onChange;

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
        Text(
          widget.title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: AppInputArea(
            maxLines: 4,
            placeHolder: widget.title,
            controller: widget.textController,
            onChange: (value) => _setOnChangeText(value),
          ),
        ),
        if (widget.error?.isNotEmpty ?? false)
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

  _setOnChangeText(String value) {
    widget.onChange?.call(value);
  }
}
