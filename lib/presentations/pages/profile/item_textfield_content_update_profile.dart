import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

class ItemCodeAndDateOfBirthUpdateProfile extends StatefulWidget {
  const ItemCodeAndDateOfBirthUpdateProfile({
    super.key,
    this.code = '',
    this.dateOfBirth = '',
    required this.onChangeCode,
    required this.onChangeDateOfBirth,
  });

  final ValueChanged<String> onChangeCode;
  final ValueChanged<String> onChangeDateOfBirth;
  final String code;
  final String dateOfBirth;

  @override
  State<ItemCodeAndDateOfBirthUpdateProfile> createState() =>
      _ItemCodeAndDateOfBirthUpdateProfileState();
}

class _ItemCodeAndDateOfBirthUpdateProfileState extends State<ItemCodeAndDateOfBirthUpdateProfile> {
  late TextEditingController contentController1, contentController2;

  @override
  void initState() {
    contentController1 = TextEditingController(text: widget.code);
    contentController2 = TextEditingController(text: widget.dateOfBirth);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: AppInput(
                controller: contentController1,
                maxLines: 1,
                onChange: (values) => widget.onChangeCode,
              ),
            ),
            const SizedBox(
              width: SpacingUnit.x3,
            ),
            Expanded(
              child: DatePicker(
                onChange: (value) => widget.onChangeDateOfBirth,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x4_5,
        ),
      ],
    );
  }
}
