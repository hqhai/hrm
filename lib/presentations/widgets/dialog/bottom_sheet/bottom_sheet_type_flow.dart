import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetTypeFlowWidget extends StatefulWidget {
  const BottomSheetTypeFlowWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<RequisitionTypeEnum> onChange;

  @override
  State<BottomSheetTypeFlowWidget> createState() => _BottomSheetTypeFlowWidgetState();
}

class _BottomSheetTypeFlowWidgetState extends State<BottomSheetTypeFlowWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.4,
      color: colors.background,
      child: Center(
        child: ListView.builder(
          itemCount: RequisitionTypeEnum.values.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => setOnChange(
              type: RequisitionTypeEnum.values[index],
            ),
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
                    RequisitionTypeEnum.values[index].configTypeName,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  setOnChange({required RequisitionTypeEnum type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
