import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_common/dialog_title.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemStepFlow extends StatelessWidget {
  const ItemStepFlow(
      {super.key,
      this.nameUserApprove = '',
      this.checkApprove = false,
      this.isNotFirst = true,
      this.note = ''});

  final String note;
  final String nameUserApprove;
  final bool checkApprove;
  final bool isNotFirst;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: SpacingUnit.x4,
              width: SpacingUnit.x4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SpacingUnit.x50),
                color: checkApprove ? colors.success : colors.surfaceVariantHigh,
                border: Border.all(
                  width: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3),
              child: Text(
                nameUserApprove,
                style: TextStyle(
                  color: checkApprove ? colors.success : colors.surfaceVariantHigh,
                  fontSize: SpacingUnit.x3,
                ),
              ),
            ),
            if (note.isNotEmpty)
              InkWell(
                onTap: () => getNote(context),
                child: Icon(
                  Icons.edit,
                  color: colors.text,
                  size: SpacingUnit.x4,
                ),
              )
          ],
        ),
        if (isNotFirst)
          Padding(
            padding: const EdgeInsets.only(
              left: SpacingUnit.x2,
            ),
            child: SizedBox(
              height: SpacingUnit.x6,
              child: VerticalDivider(
                color: checkApprove ? colors.success : colors.surfaceVariantHigh,
                width: SpacingUnit.x0_25,
              ),
            ),
          ),
      ],
    );
  }

  getNote(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: TitleDialog(
            title: note,
          ),
        );
      },
    );
  }
}
