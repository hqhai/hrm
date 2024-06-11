import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateReasonOnLeave extends StatefulWidget {
  const ItemCreateReasonOnLeave({super.key, this.onChange});

  final ValueChanged<RequisitionTypeOnLeaveEnum>? onChange;

  @override
  State<ItemCreateReasonOnLeave> createState() => _ItemCreateReasonOnLeaveState();
}

class _ItemCreateReasonOnLeaveState extends State<ItemCreateReasonOnLeave> {
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
          child: DropdownMenu<RequisitionTypeOnLeaveEnum>(
            width: width * 0.8,
            textStyle: const TextStyle(fontSize: SpacingUnit.x4),
            initialSelection: RequisitionTypeOnLeaveEnum.sickLeave,
            onSelected: (RequisitionTypeOnLeaveEnum? value) =>
                _onChangeReasonForExplanation(value),
            menuHeight: SpacingUnit.x50,
            dropdownMenuEntries: RequisitionTypeOnLeaveEnum.values
                .map(
                  (value) => DropdownMenuEntry<RequisitionTypeOnLeaveEnum>(
                    value: value,
                    label: value.configRequisitionTypeOnLeaveName,
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  _onChangeReasonForExplanation(RequisitionTypeOnLeaveEnum? value) {
    widget.onChange?.call(value ?? RequisitionTypeOnLeaveEnum.sickLeave);
  }
}
