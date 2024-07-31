import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetTimeKeepingTypeWidget extends StatefulWidget {
  const BottomSheetTimeKeepingTypeWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<EditTimekeeping> onChange;

  @override
  State<BottomSheetTimeKeepingTypeWidget> createState() => _BottomSheetTimeKeepingTypeWidgetState();
}

class _BottomSheetTimeKeepingTypeWidgetState extends State<BottomSheetTimeKeepingTypeWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(
        SpacingUnit.x3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: EditTimekeeping.values
            .where((e) => e != EditTimekeeping.editTimekeeping)
            .mapIndexed(
              (index, element) => GestureDetector(
                onTap: () => addType(type: element),
                child: ContainerBorder(
                  padding: SpacingUnit.x2,
                  margin: SpacingUnit.x2,
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
                        element.configEditTimekeepingName,
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

  addType({required EditTimekeeping type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
