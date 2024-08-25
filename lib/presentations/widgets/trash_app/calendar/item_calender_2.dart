import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemHorizontal extends StatelessWidget {
  final bool isNowDate;
  final Note note;
  final int month;
  final int noteIndex;
  final DateTime date;
  final Widget itemDate;

  const ItemHorizontal({
    super.key,
    required this.note,
    required this.noteIndex,
    required this.date,
    required this.month,
    required this.itemDate,
    required this.isNowDate,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final width = MediaQuery
        .sizeOf(context)
        .width;
    return Container(
      width: width - SpacingUnit.x10 - 0.5,
      margin: const EdgeInsets.all(SpacingUnit.x5),
      padding: const EdgeInsets.all(SpacingUnit.x5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color: colors.text.withOpacity(0.05),
        border: Border.all(
          color: colors.text.withOpacity(0.05),
          width: 1,
        ),
      ),
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: isNowDate ? colors.primary : Colors.transparent,
                child: Text(
                  date.day.toString(),
                  style: theme.textTheme.titleLarge!.copyWith(color: colors.text),
                ),
              ),
            ),
          ),
          if (note.note != '')
            Expanded(
              flex: 10,
              child: Text(
                appLocalizations.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x6),
              ),
            ),
          Expanded(
            flex: note.note != '' ? 70 : 80,
            child: Text(
              note.note,
              maxLines: 15,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
            ),
          ),
        ],
      ),
    );
  }
}

class ItemVertical extends StatelessWidget {
  final bool isNowDate;
  final Note note;
  final int month;
  final int noteIndex;
  final DateTime date;
  final Widget itemDate;

  const ItemVertical({
    super.key,
    required this.note,
    required this.noteIndex,
    required this.date,
    required this.month,
    required this.itemDate,
    required this.isNowDate,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return ContainerBorder(
      backgroundColors: colors.text.withOpacity(0.05),
      height: width * 0.3,
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x1
        ),
        child: Row(
          children: [
            Expanded(
              flex: 80,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(note.note,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4)),
              ),
            ),
            Expanded(
              flex: 20,
              child: CircleAvatar(
                backgroundColor: isNowDate ? colors.primary : Colors.transparent,
                child: Text(
                  date.day.toString(),
                  style: theme.textTheme.titleLarge!.copyWith(color: colors.text),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}

