import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';

class PaddingRowLeave extends StatelessWidget {
  const PaddingRowLeave(
      {super.key,
      required this.title1,
      required this.value1,
      required this.title2,
      required this.value2,
      this.color});

  final String title1, value1, title2, value2;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TitleValueLeave(
              title: title1,
              value: value1,
            ),
          ),
          Expanded(
            child: TitleValueLeave(
              title: title2,
              value: value2,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
