import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_day_ot.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTakeOvertimeDay extends StatefulWidget {
  const ItemTakeOvertimeDay({
    super.key,
    required this.type,
    required this.onChangeType,
  });

  final EnumOvertimeDay type;
  final ValueChanged<EnumOvertimeDay> onChangeType;

  @override
  State<ItemTakeOvertimeDay> createState() => _ItemTakeOvertimeDayState();
}

class _ItemTakeOvertimeDayState extends State<ItemTakeOvertimeDay> {
  EnumOvertimeDay takeOTType = EnumOvertimeDay.holiday;

  @override
  void initState() {
    takeOTType = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleRequired(
            title: appLocalizations.dateType,
            requiredValidate: true,
          ),
          GestureDetector(
            onTap: () => setTakeLeave(context),
            child: ContainerBorder(
              paddingVertical: SpacingUnit.x4,
              width: width,
              borderColors: colors.text.withValues(alpha: 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    takeOTType.configEnumOvertimeDayName,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    size: SpacingUnit.x6,
                    color: colors.text,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  setTakeLeave(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetOverTimeDayWidget(
          overtimeDay: takeOTType,
          onChange: (value) => setEnumType(value),
        );
      },
    );
  }

  setEnumType(EnumOvertimeDay value) {
    setState(() {
      takeOTType = value;
      widget.onChangeType.call(takeOTType);
    });
  }
}
