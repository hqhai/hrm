import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:widgets/app_input.dart';

class ItemInputUpdateProfile extends StatefulWidget {
  final String? error;
  final ValueChanged<String> onChange;
  final String content;
  final String title;
  final bool requiredValidate;

  const ItemInputUpdateProfile({
    super.key,
    this.title = '',
    this.content = '',
    required this.onChange,
    this.error,
    this.requiredValidate = false,
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        TitleRequired(title: widget.title, requiredValidate: widget.requiredValidate),
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        AppInput(
          controller: contentController,
          maxLines: 1,
          onChange: (values) => _setOnChange(values),
          error: widget.error,
        ),
        const SizedBox(
          height: SpacingUnit.x3,
        ),
      ],
    );
  }

  _setOnChange(String values) {
    widget.onChange.call(values);
  }
}
