import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateTime extends StatefulWidget {
  const ItemCreateTime({
    super.key,
    this.dateOfBirth,
    required this.onChangeDateOfBirth,
    this.title = '',
    this.check = false,
  });

  final bool check;
  final ValueChanged<DateTime> onChangeDateOfBirth;
  final String title;
  final DateTime? dateOfBirth;

  @override
  State<ItemCreateTime> createState() => _ItemCreateTimeState();
}

class _ItemCreateTimeState extends State<ItemCreateTime> {
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
                color: widget.check ? colors.text : colors.tertiary,
                fontSize: SpacingUnit.x4,
                fontWeight: widget.check? FontWeight.w800 : FontWeight.w400
              ),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
            TimePicker(
              onChange: (value) => _setOnChange(value),
              timeSlot: widget.dateOfBirth,
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
    widget.onChangeDateOfBirth.call(value);
  }
}
