import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateReasonForExplanation extends StatefulWidget {
  const ItemCreateReasonForExplanation({super.key, this.onChange});

  final ValueChanged<RequisitionTypeExplanationEnum>? onChange;

  @override
  State<ItemCreateReasonForExplanation> createState() => _ItemCreateReasonForExplanationState();
}

class _ItemCreateReasonForExplanationState extends State<ItemCreateReasonForExplanation> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.reasonForExplanation,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: DropdownMenu<RequisitionTypeExplanationEnum>(
            width: width * 0.8,
            textStyle: const TextStyle(fontSize: SpacingUnit.x4),
            initialSelection: RequisitionTypeExplanationEnum.late,
            onSelected: (RequisitionTypeExplanationEnum? value) =>
                _onChangeReasonForExplanation(value),
            menuHeight: SpacingUnit.x50,
            dropdownMenuEntries: RequisitionTypeExplanationEnum.values
                .map(
                  (value) => DropdownMenuEntry<RequisitionTypeExplanationEnum>(
                    value: value,
                    label: value.configRequisitionTypeExplanationName,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  _onChangeReasonForExplanation(RequisitionTypeExplanationEnum? value) {
    widget.onChange?.call(value ?? RequisitionTypeExplanationEnum.late);
  }
}
