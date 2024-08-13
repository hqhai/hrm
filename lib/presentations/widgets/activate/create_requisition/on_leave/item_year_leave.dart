import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemYearLeave extends StatefulWidget {
  const ItemYearLeave(
      {super.key,
      required this.onChange,
      required this.type,
      required this.onChangeSocialInsurance,
      this.typeReason,
      this.typeSocialInsurance});

  final ValueChanged<EnumReasonLeave?> onChange;
  final ValueChanged<EnumSocialInsuranceLeave?> onChangeSocialInsurance;
  final EnumTakeLeaveType type;
  final EnumReasonLeave? typeReason;
  final EnumSocialInsuranceLeave? typeSocialInsurance;

  @override
  State<ItemYearLeave> createState() => _ItemYearLeaveState();
}

class _ItemYearLeaveState extends State<ItemYearLeave> {
  EnumReasonLeave? type;
  EnumSocialInsuranceLeave? socialInsuranceLeave;

  @override
  void initState() {
    type = widget.typeReason;
    socialInsuranceLeave = widget.typeSocialInsurance;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.reason,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (widget.type == EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave)
          item(
            context: context,
            type1: EnumReasonLeave.yearlyLeave,
            type2: EnumReasonLeave.seniorityLeave,
          ),
        if (widget.type == EnumTakeLeaveType.unpaidLeave)
          item(
            context: context,
            type1: EnumReasonLeave.noSalaryLeave,
            type2: EnumReasonLeave.socialInsuranceLeave,
          ),
        if (type == EnumReasonLeave.socialInsuranceLeave &&
            widget.type == EnumTakeLeaveType.unpaidLeave)
          itemSocialInsuranceLeave(
            context: context,
          ),
        if (widget.type == EnumTakeLeaveType.otherPaidLeave)
          item(
            context: context,
            type1: EnumReasonLeave.weddingLeave,
            type2: EnumReasonLeave.mourningLeave,
          ),
        if (widget.type == EnumTakeLeaveType.compensatoryLeave)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
            child: Text(
              EnumTakeLeaveType.compensatoryLeave.configTakeLeaveTypeName,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
      ],
    );
  }

  //EnumSocialInsuranceLeave

  Widget itemSocialInsuranceLeave({required BuildContext context}) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: EnumSocialInsuranceLeave.values
          .map(
            (e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x1),
              child: ContainerBorder(
                borderColors: colors.text.withOpacity(0.3),
                marginTop: SpacingUnit.x2,
                paddingVertical: 0,
                child: ListTile(
                  title: Text(
                    e.configSocialInsuranceLeaveName,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3,
                    ),
                  ),
                  leading: Radio<EnumSocialInsuranceLeave>(
                    value: e,
                    groupValue: socialInsuranceLeave,
                    onChanged: (EnumSocialInsuranceLeave? value) =>
                        _setSocialInsuranceLeave(value),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget item(
      {required BuildContext context,
      required EnumReasonLeave type1,
      required EnumReasonLeave type2}) {
    final colors = AppTheme.getColors(context);
    return Row(
      children: [
        Expanded(
          child: ContainerBorder(
            borderColors: colors.text.withOpacity(0.3),
            marginTop: 0,
            paddingVertical: 0,
            paddingHorizontal: 0,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: FittedBox(
                child: Text(
                  '${type1.configEnumTakeLeaveName} ',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
              leading: Radio<EnumReasonLeave>(
                value: type1,
                groupValue: type,
                onChanged: (EnumReasonLeave? value) => _setType(value),
              ),
            ),
          ),
        ),
        const SizedBox(width: SpacingUnit.x2),
        Expanded(
          child: ContainerBorder(
            marginTop: 0,
            borderColors: colors.text.withOpacity(0.3),
            paddingHorizontal: 0,
            paddingVertical: 0,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                type2.configEnumTakeLeaveName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              leading: Radio<EnumReasonLeave>(
                value: type2,
                groupValue: type,
                onChanged: (EnumReasonLeave? value) => _setType(value),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _setType(EnumReasonLeave? value) {
    setState(() {
      if (widget.type == EnumTakeLeaveType.compensatoryLeave) {
        type = null;
      }
      type = value;
      if (widget.type != EnumTakeLeaveType.unpaidLeave ||
          value != EnumReasonLeave.socialInsuranceLeave) {
        socialInsuranceLeave = null;
        widget.onChangeSocialInsurance.call(socialInsuranceLeave);
      }
      widget.onChange.call(value);
    });
  }

  _setSocialInsuranceLeave(EnumSocialInsuranceLeave? value) {
    setState(() {
      if (widget.type == EnumTakeLeaveType.unpaidLeave &&
          type == EnumReasonLeave.socialInsuranceLeave) {
        socialInsuranceLeave = value;
        widget.onChangeSocialInsurance.call(socialInsuranceLeave);
      }
    });
  }
}
