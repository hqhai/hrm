import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/tab_bar_attendance.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TabBarWorkSheet extends StatefulWidget {
  const TabBarWorkSheet(
      {super.key, required this.setIndex, required this.index});
  final ValueChanged<int> setIndex;
  final int index;
  @override
  State<TabBarWorkSheet> createState() => _TabBarWorkSheetState();
}

class _TabBarWorkSheetState extends State<TabBarWorkSheet> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: tabBarAttendance(context).length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () => _setIndex(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                top: const BorderSide(width: 0),
                bottom: index == widget.index
                    ? BorderSide(width: 3, color: colors.outline)
                    : const BorderSide(width: 0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3),
              child: Center(
                child: Text(
                  tabBarAttendance(context)[index],
                  style: TextStyle(
                    color: index == widget.index
                        ? colors.text
                        : colors.outline.withValues(alpha: 0.6),
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _setIndex(int index) {
    widget.setIndex.call(index);
  }
}
