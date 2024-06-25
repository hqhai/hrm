import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_take_leave.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemTakeLeave extends StatefulWidget {
  const ItemTakeLeave({super.key, required this.type, required this.onChange});

  final RequisitionTypeEnum type;
  final ValueChanged<EnumTakeLeave> onChange;

  @override
  State<ItemTakeLeave> createState() => _ItemTakeLeaveState();
}

class _ItemTakeLeaveState extends State<ItemTakeLeave> {
  EnumTakeLeave takeLeave = EnumTakeLeave.yearlyLeave;
  List<EnumTakeLeave> listTakeLeave = [];

  @override
  void initState() {
    takeLeave = listEnumTakeLeave();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                appLocalizations.detailedReason,
                style: TextStyle(
                    color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                width: SpacingUnit.x4,
              ),
              GestureDetector(
                onTap: () => setTakeLeave(context),
                child: Icon(
                  Icons.add_circle,
                  color: colors.success,
                  size: SpacingUnit.x6,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: SpacingUnit.x3,
          ),
          Text(
            takeLeave.configEnumTakeLeaveName,
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
          ),
        ],
      ),
    );
  }

  EnumTakeLeave listEnumTakeLeave() {
    switch (widget.type) {
      case RequisitionTypeEnum.yearlyAndSeniorityLeave:
        listTakeLeave = [
          EnumTakeLeave.yearlyLeave,
          EnumTakeLeave.seniorityLeave,
        ];
        return EnumTakeLeave.yearlyLeave;
      case RequisitionTypeEnum.compensatoryLeave:
        listTakeLeave = [EnumTakeLeave.compensatoryLeave];
        return EnumTakeLeave.compensatoryLeave;
      case RequisitionTypeEnum.otherLeave:
        listTakeLeave = [
          EnumTakeLeave.weddingLeave,
          EnumTakeLeave.mourningLeave,
        ];
        return EnumTakeLeave.weddingLeave;
      case RequisitionTypeEnum.unpaidLeave:
        listTakeLeave = [
          EnumTakeLeave.homeSickLeave,
          EnumTakeLeave.hospitalSickLeave,
          EnumTakeLeave.maternityLeave,
        ];
        return EnumTakeLeave.homeSickLeave;
      default:
        return EnumTakeLeave.yearlyLeave;
    }
  }

  setTakeLeave(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetLeaveWidget(
          listEnumTakeLeave: listTakeLeave,
          onChange: (value) => setEnumTakeLeave(value),
        );
      },
    );
  }

  setEnumTakeLeave(EnumTakeLeave value) {
    setState(() {
      takeLeave = value;
      widget.onChange.call(takeLeave);
    });
  }
}
