import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetLeaveWidget extends StatefulWidget {
  const BottomSheetLeaveWidget({
    super.key,
    required this.onChange,
    this.listEnumTakeLeave = const [],
  });

  final ValueChanged<EnumTakeLeave> onChange;
  final List<EnumTakeLeave> listEnumTakeLeave;

  @override
  State<BottomSheetLeaveWidget> createState() => _BottomSheetLeaveWidgetState();
}

class _BottomSheetLeaveWidgetState extends State<BottomSheetLeaveWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.25,
      color: colors.surface,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: widget.listEnumTakeLeave
                .mapIndexed(
                  (index, element) => GestureDetector(
                    onTap: () => setOnChange(
                      type: widget.listEnumTakeLeave[index],
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(SpacingUnit.x3),
                      margin: const EdgeInsets.all(SpacingUnit.x2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SpacingUnit.x2),
                        color: CustomsColor.colorBackground,
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
                            widget.listEnumTakeLeave[index].configEnumTakeLeaveName,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  setOnChange({required EnumTakeLeave type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
