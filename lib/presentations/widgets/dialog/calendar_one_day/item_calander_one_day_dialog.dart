import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCalenderOneDateDialog extends StatelessWidget {
  final bool isNowDate;
  final DateTime date;
  final int month;
  final bool checkOnSelect;
  final bool isActive;

  const ItemCalenderOneDateDialog(
      {super.key,
      required this.date,
      required this.isNowDate,
      required this.month,
      required this.checkOnSelect,
      this.isActive = true});

  UserWorkingHistoryModel? userWorkingHistoryModelByDate(
      List<UserWorkingHistoryModel> list) {
    final int index = list
        .indexWhere((element) => element.date?.isAtSameMomentAs(date) ?? false);
    if (index != -1) {
      return list[index];
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ContainerBorder(
      marginTop: 0,
      paddingVertical: 0,
      paddingHorizontal: 0,
      circular: SpacingUnit.x10,
      widthBorder: 1,
      backgroundColors: _colorCircular(context),
      borderColors: _colorCircularBorder(context),
      child: Center(
        child: Text(
          date.day.toString(),
          style: TextStyle(
            color: isActive ? _colorText(context) : Colors.grey,
            fontSize: SpacingUnit.x3_5,
          ),
        ),
      ),
    );
  }

  Color _colorCircular(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return checkOnSelect
        ? colors.primary
        : colors.background.withValues(alpha: 0);
  }

  Color _colorCircularBorder(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return isNowDate ? colors.primary : colors.background.withValues(alpha: 0);
  }

  Color _colorText(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return month != date.month
        ? colors.outlineVariant.withValues(alpha: 0.3)
        : (checkOnSelect ? colors.background : colors.text);
  }
}
