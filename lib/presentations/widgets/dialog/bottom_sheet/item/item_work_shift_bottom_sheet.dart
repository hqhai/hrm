import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/item/item_bottom_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemSheetWorkShiftBSWidget extends StatelessWidget {
  const ItemSheetWorkShiftBSWidget({
    super.key,
    this.index = 0,
    this.value = '',
    this.explanations = const [],
    required this.setExplanation,
    this.selectExplanations = const [],
  });

  final int index;
  final String value;
  final List<Explanation> explanations;
  final ValueChanged<Explanation> setExplanation;
  final List<Explanation> selectExplanations;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final newSelectExplanations =
        selectExplanations.map((e) => e.copyWith(note: '')).toList();
    final explanationsUnSelect = explanations
        .where((element) => !newSelectExplanations.contains(element));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
      child: ContainerBorder(
        borderColors: colors.tertiary.withValues(alpha: 0.1),
        backgroundColors: colors.tertiary.withValues(alpha: 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              value,
              style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w500),
            ),
            Column(
              children: explanationsUnSelect
                  .mapIndexed(
                    (index, element) => InkWell(
                      onTap: () => _setExplanation(element),
                      child: ItemBottomSheet(
                          check: false,
                          index: index,
                          value:
                              '${strSeconds(element.checkIn)} - ${strSeconds(element.checkOut)}'),
                    ),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  _setExplanation(Explanation element) {
    setExplanation.call(element);
  }
}
