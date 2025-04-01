import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_buttom_read_more_over_time.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_info_over_time.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/requisition_overtime_header.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RequisitionOverTimeBody extends StatefulWidget {
  const RequisitionOverTimeBody(
      {super.key, required this.data, required this.onShowDialog});
  final List<RequisitionOverTime> data;
  final VoidCallback onShowDialog;

  @override
  State<RequisitionOverTimeBody> createState() =>
      _RequisitionOverTimeBodyState();
}

class _RequisitionOverTimeBodyState extends State<RequisitionOverTimeBody> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          appLocalizations.i18nOTInformation,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x3_5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const RequisitionOvertimeHeader(),
        Flexible(
          child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => ItemInfoOverTime(
                    data: widget.data[index],
                  ),
              // separatorBuilder: (context, index) => const Divider(),
              itemCount: ((widget.data.length) > 5) ? 5 : widget.data.length),
        ),
        if (widget.data.length > 5)
          ItemButtonReadMoreOvertime(
            onShowDialog: widget.onShowDialog,
          ),
      ],
    );
  }
}
