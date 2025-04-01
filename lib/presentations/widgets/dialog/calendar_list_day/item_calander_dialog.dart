import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCalenderDialog extends StatelessWidget {
  final bool isNowDate;
  final DateTime date;
  final int month;
  final bool checkOnSelect;
  final bool checkStartSelectDay;
  final bool checkEndSelectDay;
  final bool checkEnd;

  const ItemCalenderDialog({
    super.key,
    required this.date,
    required this.isNowDate,
    required this.month,
    required this.checkOnSelect,
    required this.checkStartSelectDay,
    required this.checkEndSelectDay,
    required this.checkEnd,
  });

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
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                color: _colorEnd(context),
              ),
            ),
            Expanded(
              child: Container(
                color: _colorStart(context),
              ),
            )
          ],
        ),
        ContainerBorder(
          marginTop: 0,
          paddingVertical: 0,
          paddingHorizontal: 0,
          circular: SpacingUnit.x10,
          widthBorder: 0.5,
          backgroundColors: _colorCircular(context),
          borderColors: _colorCircularBorder(context),
          child: Center(
            child: Text(
              date.day.toString(),
              style: TextStyle(
                color: _colorText(context),
                fontSize: SpacingUnit.x3_5,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Color _colorStart(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return (checkStartSelectDay || checkOnSelect) && checkEnd
        ? colors.tertiary.withValues(alpha: 0.5)
        : colors.background;
  }

  Color _colorEnd(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return (checkEndSelectDay || checkOnSelect) && checkEnd
        ? colors.tertiary.withValues(alpha: 0.5)
        : colors.background;
  }

  Color _colorCircular(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return checkEndSelectDay || checkStartSelectDay
        ? colors.tertiary
        : isNowDate
            ? colors.primary
            : colors.background.withValues(alpha: 0);
  }

  Color _colorCircularBorder(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return checkEndSelectDay || checkStartSelectDay
        ? colors.tertiary
        : colors.background.withValues(alpha: 0);
  }

  Color _colorText(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return month != date.month
        ? colors.outlineVariant.withValues(alpha: 0.3)
        : (isNowDate ? colors.background : colors.text);
  }
}
