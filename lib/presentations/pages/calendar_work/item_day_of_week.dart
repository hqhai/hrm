import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemDayOfWeek extends StatelessWidget {
  const ItemDayOfWeek({super.key, required this.index, required this.time});

  final int index;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return ContainerBorder(
      borderColors: colors.surface,
      padding: SpacingUnit.x1_5,
      margin: 0,
      backgroundColors: check() ? colors.surfaceVariant : colors.surface,
      child: SizedBox(
        child: Column(
          children: [
            Text(
              mapNameInWeek[index + 1] ?? "",
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
            ),
            const SizedBox(
              height: SpacingUnit.x1,
            ),
            Text(
              time.day.toString(),
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
            ),
          ],
        ),
      ),
    );
  }

  bool check() {
    final bool checkNow = time.day == DateTime.now().day && time.month == DateTime.now().month;
    return checkNow;
  }
}
