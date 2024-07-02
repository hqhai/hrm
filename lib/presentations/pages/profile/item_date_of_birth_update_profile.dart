import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemDateOfBirthUpdateProfile extends StatefulWidget {
  const ItemDateOfBirthUpdateProfile({
    super.key,
    this.dateOfBirth = '',
    required this.onChangeDateOfBirth,
    this.title = '',
    this.check = false,
  });

  final bool check;
  final ValueChanged<String> onChangeDateOfBirth;
  final String title;
  final String dateOfBirth;

  @override
  State<ItemDateOfBirthUpdateProfile> createState() => _ItemDateOfBirthUpdateProfileState();
}

class _ItemDateOfBirthUpdateProfileState extends State<ItemDateOfBirthUpdateProfile> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
                fontWeight: widget.check? FontWeight.w800 : FontWeight.w400
              ),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
            DatePicker(
              check: false,
              onChange: (value) => _setOnChange(value),
              oldDate: DateTime.tryParse(widget.dateOfBirth),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x2,
        ),
      ],
    );
  }

  _setOnChange(DateTime value) {
    widget.onChangeDateOfBirth.call(value.toString());
  }
}
