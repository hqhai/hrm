import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

class ItemInputUpdateProfile extends StatefulWidget {
  final String? error;
  final ValueChanged<String> onChange;
  final String content;
  final String title;

  const ItemInputUpdateProfile({
    super.key,
    this.title = '',
    this.content = '',
    required this.onChange,
    this.error,
  });

  @override
  State<ItemInputUpdateProfile> createState() => _ItemInputUpdateProfileState();
}

class _ItemInputUpdateProfileState extends State<ItemInputUpdateProfile> {
  late TextEditingController contentController;

  @override
  void initState() {
    contentController = TextEditingController(text: widget.content);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        Text(
          widget.title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        AppInput(
          controller: contentController,
          maxLines: 1,
          onChange: (values) => _setOnChange(values),
        ),
        const SizedBox(
          height: SpacingUnit.x3,
        ),
        if (widget.error?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingUnit.x3),
            child: Text(
              widget.error ?? "",
              style: TextStyle(color: colors.error, fontSize: SpacingUnit.x3),
            ),
          ),
      ],
    );
  }

  _setOnChange(String values) {
    widget.onChange.call(values);
  }
}
