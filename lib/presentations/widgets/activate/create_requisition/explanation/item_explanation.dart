import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemExplanation extends StatefulWidget {
  final Explanation explanation;

  const ItemExplanation({super.key, required this.explanation});

  @override
  State<ItemExplanation> createState() => _ItemExplanationState();
}

class _ItemExplanationState extends State<ItemExplanation> {
  bool showNote = false;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return ContainerBorder(
      borderColors: colors.text.withOpacity(0.3),
      padding: SpacingUnit.x4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: SpacingUnit.x1, top: SpacingUnit.x2, bottom: SpacingUnit.x2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatYMD(widget.explanation.workDate.toString()),
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                InkWell(
                  onTap: () => setShowNote(),
                  child: SvgPicture.asset(
                    width: SpacingUnit.x6,
                    height: SpacingUnit.x6,
                    showNote
                        ? Assets.images.icon.home.chevronForward
                        : Assets.images.icon.activateIcon.drop,
                    colorFilter: ColorFilter.mode(colors.text.withOpacity(0.4), BlendMode.srcIn),
                  ),
                ),
              ],
            ),
          ),
          if (showNote)
            ItemTitleValueNoBorder(
              size: SpacingUnit.x4,
              title: appLocalizations.shift,
              value:
                  '${strSeconds(widget.explanation.startTime) ?? ""} - ${strSeconds(widget.explanation.endTime) ?? ""}',
            ),
          if (showNote)
            Text(
              appLocalizations.note,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
          if (showNote)
            ContainerBorder(
              borderColors: colors.text.withOpacity(0.3),
              padding: SpacingUnit.x4,
              height: SpacingUnit.x30,
              width: width,
              child: SingleChildScrollView(
                child: Text(
                  widget.explanation.note,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  setShowNote() {
    setState(() {
      showNote = !showNote;
    });
  }
}
