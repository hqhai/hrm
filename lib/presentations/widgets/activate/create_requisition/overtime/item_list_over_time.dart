import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemListOverTime extends StatefulWidget {
  const ItemListOverTime({
    super.key,
    required this.requisitionOverTime,
    required this.index,
    required this.checkType,
  });

  final RequisitionOverTime requisitionOverTime;
  final int index;
  final RequestType checkType;

  @override
  State<ItemListOverTime> createState() => _ItemListOverTimeState();
}

class _ItemListOverTimeState extends State<ItemListOverTime> {
  bool showNote = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return ContainerBorder(
      paddingVertical: SpacingUnit.x2_5,
      marginTop: SpacingUnit.x2_5,
      borderColors: colors.text.withOpacity(0.3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ItemTitleValueNoBorder(
            title: appLocalizations.date,
            value:
                formatYMD((widget.requisitionOverTime.date ?? "").toString()),
            size: SpacingUnit.x4,
          ),
          if (widget.checkType == RequestType.oT)
            ItemTitleValueNoBorder(
              title: appLocalizations.dateType,
              value: widget.requisitionOverTime.overTimeDay
                      ?.configEnumOvertimeDayName ??
                  "",
              size: SpacingUnit.x4,
            ),
          if (widget.checkType == RequestType.oT)
            ItemTitleValueNoBorder(
              title: appLocalizations.destinationOT,
              value: widget.requisitionOverTime.isChecking
                  ? appLocalizations.inCompany
                  : appLocalizations.outCompany,
              size: SpacingUnit.x4,
            ),
          ItemTitleValueNoBorder(
            title: appLocalizations.startTime,
            value: strSeconds(widget.requisitionOverTime.startTime) ?? "",
            size: SpacingUnit.x4,
          ),
          ItemTitleValueNoBorder(
            title: appLocalizations.endTime,
            value: strSeconds(widget.requisitionOverTime.endTime) ?? "",
            size: SpacingUnit.x4,
          ),
          if (widget.checkType == RequestType.oT ||
              widget.checkType == RequestType.makeUp)
            ItemTitleValueNoBorder(
              title: widget.checkType == RequestType.oT
                  ? appLocalizations.totalOTHours
                  : appLocalizations.totalMakeUpWorkTime,
              value:
                  strSeconds(widget.requisitionOverTime.suggestTime.toInt()) ??
                      "",
              size: SpacingUnit.x4,
            ),
          if (widget.checkType == RequestType.oT)
            Padding(
              padding: const EdgeInsets.only(
                  left: SpacingUnit.x1,
                  top: SpacingUnit.x2,
                  bottom: SpacingUnit.x2),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.note,
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
                      colorFilter: ColorFilter.mode(
                          colors.text.withOpacity(0.4), BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          if (showNote &&
              widget.requisitionOverTime.note.isNotEmpty &&
              widget.checkType == RequestType.oT)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
              child: Text(
                widget.requisitionOverTime.note,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
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
