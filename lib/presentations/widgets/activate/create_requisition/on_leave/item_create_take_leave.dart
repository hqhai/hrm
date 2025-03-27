import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_take_leave.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTakeLeave extends StatefulWidget {
  const ItemTakeLeave({
    super.key,
    required this.type,
    required this.onChangeType,
  });

  final EnumTakeLeaveType type;
  final ValueChanged<EnumTakeLeaveType> onChangeType;

  @override
  State<ItemTakeLeave> createState() => _ItemTakeLeaveState();
}

class _ItemTakeLeaveState extends State<ItemTakeLeave> {
  EnumTakeLeaveType takeLeaveType =
      EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave;

  @override
  void initState() {
    takeLeaveType = widget.type;
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
            title: appLocalizations.selectTypeLeave,
            requiredValidate: true,
          ),
          GestureDetector(
            onTap: () => setTakeLeave(context),
            child: ContainerBorder(
              width: width,
              borderColors: colors.outline.withValues(alpha: 0.3),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    takeLeaveType.configTakeLeaveTypeName,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down_sharp,
                    color: colors.text,
                    size: SpacingUnit.x6,
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
        return BottomSheetLeaveWidget(
          listEnumTakeLeave: takeLeaveType,
          onChange: (value) => setEnumTakeLeave(value),
        );
      },
    );
  }

  setEnumTakeLeave(EnumTakeLeaveType value) {
    setState(() {
      takeLeaveType = value;
      widget.onChangeType.call(takeLeaveType);
    });
  }
}
