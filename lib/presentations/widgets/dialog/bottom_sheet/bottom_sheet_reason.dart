import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetReasonTypeWidget extends StatefulWidget {
  const BottomSheetReasonTypeWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<EnumReason> onChange;

  @override
  State<BottomSheetReasonTypeWidget> createState() => _BottomSheetReasonTypeWidgetState();
}

class _BottomSheetReasonTypeWidgetState extends State<BottomSheetReasonTypeWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x5,
        horizontal: SpacingUnit.x3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: EnumReason.values
            .mapIndexed(
              (index, element) => GestureDetector(
                onTap: () => addType(type: element),
                child: ContainerBorder(
                  padding: SpacingUnit.x4,
                  margin: SpacingUnit.x4,
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
                        element.configEnumReasonName,
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
    );
  }

  addType({required EnumReason type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
