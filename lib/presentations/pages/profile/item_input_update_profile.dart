import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

class ItemInputUpdateProfile extends StatefulWidget {
  const ItemInputUpdateProfile({
    super.key,
    this.title= '',
    this.content = '',
    required this.onChange,
  });

  final ValueChanged<String> onChange;
  final String content;
  final String title;

  @override
  State<ItemInputUpdateProfile> createState() =>
      _ItemInputUpdateProfileState();
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
        Text(
          widget.title,
          style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
        ),
        const SizedBox(
          height: SpacingUnit.x3,
        ),
        AppInput(
          controller: contentController,
          maxLines: 1,
          onChange: (values) => widget.onChange,
        ),
        const SizedBox(
          height: SpacingUnit.x3,
        ),
      ],
    );
  }
}
