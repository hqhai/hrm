import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';

class ItemDateOfBirthUpdateProfile extends StatefulWidget {
  const ItemDateOfBirthUpdateProfile({
    super.key,
    required this.dateOfBirth,
    required this.onChangeDateOfBirth,
    this.title = '',
  });

  final ValueChanged<DateTime> onChangeDateOfBirth;
  final String title;
  final DateTime dateOfBirth;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleRequired(title: widget.title, requiredValidate: true),
        DatePickerLoop(
          check: false,
          onChange: (value) => _setOnChange(value),
          oldDate: widget.dateOfBirth,
        ),
      ],
    );
  }

  _setOnChange(DateTime value) {
    widget.onChangeDateOfBirth.call(value);
  }
}
