import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTimeFilter extends StatefulWidget {
  const ItemTimeFilter({
    super.key,
    this.dateOfBirth,
    required this.onChangeDateOfBirth,
    this.title = '',
  });

  final ValueChanged<DateTime> onChangeDateOfBirth;
  final String title;
  final DateTime? dateOfBirth;

  @override
  State<ItemTimeFilter> createState() => _ItemTimeFilterState();
}

class _ItemTimeFilterState extends State<ItemTimeFilter> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
            child: DatePicker(
              onChange: (value) => _setOnChange(value),
              oldDate: widget.dateOfBirth,
            ),
          ),
        ],
      ),
    );
  }

  _setOnChange(DateTime value) {
    widget.onChangeDateOfBirth.call(value);
  }
}
