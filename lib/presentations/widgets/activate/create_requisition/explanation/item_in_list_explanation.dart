import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_input_area.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemInListExplanation extends StatefulWidget {
  const ItemInListExplanation({
    super.key,
    this.explanation = const Explanation(),
    required this.checkTypeContainer,
    required this.callBack,
    required this.changeExplanation,
    this.workShifts = const [],
    required this.callBackDelete,
  });

  final List<WorkShiftRegisteredDetail> workShifts;
  final Explanation explanation;
  final bool checkTypeContainer;
  final VoidCallback callBack;
  final VoidCallback callBackDelete;
  final ValueChanged<Explanation> changeExplanation;

  @override
  State<ItemInListExplanation> createState() => _ItemInListExplanationState();
}

class _ItemInListExplanationState extends State<ItemInListExplanation> {
  final TextEditingController noteController = TextEditingController();
  String note = '';

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    final appLocalizations = AppLocalizations.of(context)!;
    return ContainerBorder(
      padding: SpacingUnit.x4,
      borderColors: colors.outline.withOpacity(0.4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                formatYMD((widget.explanation.workDate ?? '').toString()),
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              InkWell(
                onTap: () => widget.callBack.call(),
                child: SvgPicture.asset(
                  widget.checkTypeContainer
                      ? Assets.images.icon.home.chevronForward
                      : Assets.images.icon.activateIcon.drop,
                  colorFilter: ColorFilter.mode(colors.text.withOpacity(0.4), BlendMode.srcIn),
                ),
              ),
            ],
          ),
          if (widget.checkTypeContainer)
            ContainerBorder(
              borderColors: colors.outline.withOpacity(0.4),
              width: width,
              padding: SpacingUnit.x4,
              child: Text(
                '${strSeconds(widget.explanation.startTime)} - ${strSeconds(widget.explanation.endTime)}',
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
          if (widget.checkTypeContainer)
            ItemCreateInputArea(
              textController: noteController,
              title: appLocalizations.note,
              onChange: (value) => _setNote(value),
            ),
          if (widget.checkTypeContainer)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: SpacingUnit.x4, horizontal: SpacingUnit.x1),
              child: AppButton(
                title: appLocalizations.cancel,
                onSubmit: () => widget.callBackDelete.call(),
                color: colors.text.withOpacity(0.4),
              ),
            )
        ],
      ),
    );
  }

  _setNote(String value) {
    final explanation = widget.explanation;
    setState(() {
      note = value;
    });
    widget.changeExplanation(explanation.copyWith(note: value));
  }
}
