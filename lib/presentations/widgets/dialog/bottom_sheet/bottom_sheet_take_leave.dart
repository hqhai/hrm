import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetLeaveWidget extends StatefulWidget {
  const BottomSheetLeaveWidget({
    super.key,
    required this.onChange,
    this.listEnumTakeLeave = EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave,
  });

  final ValueChanged<EnumTakeLeaveType> onChange;
  final EnumTakeLeaveType listEnumTakeLeave;

  @override
  State<BottomSheetLeaveWidget> createState() => _BottomSheetLeaveWidgetState();
}

class _BottomSheetLeaveWidgetState extends State<BottomSheetLeaveWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: EnumTakeLeaveType.values
              .mapIndexed((index, element) => GestureDetector(
                    onTap: () => setOnChange(type: element),
                    child: Container(
                      padding: const EdgeInsets.all(SpacingUnit.x3),
                      margin: const EdgeInsets.all(SpacingUnit.x2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SpacingUnit.x2),
                        color: colors.background,
                        border: Border.all(
                          color: colors.text,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            '${index + 1}.    ',
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                          Text(
                            element.configTakeLeaveTypeName,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList()),
    );
  }

  setOnChange({required EnumTakeLeaveType type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
