import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateTimeYMD extends StatefulWidget {
  const ItemCreateTimeYMD({
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
  State<ItemCreateTimeYMD> createState() => _ItemCreateTimeYMDState();
}

class _ItemCreateTimeYMDState extends State<ItemCreateTimeYMD> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
                color: widget.check ? colors.text : colors.tertiary,
                fontSize: SpacingUnit.x4,
                fontWeight: widget.check ? FontWeight.w800 : FontWeight.w400),
          ),
          const SizedBox(
            height: SpacingUnit.x3,
          ),
          DatePickerLoop(
            onChange: (value) => _setOnChange(value),
            oldDate: widget.dateOfBirth,
          ),
          const SizedBox(
            height: SpacingUnit.x3,
          ),
        ],
      ),
    );
  }

  _setOnChange(DateTime value) {
    widget.onChangeDateOfBirth.call(value);
  }
}
