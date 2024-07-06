import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetTypeLeaveWidget extends StatefulWidget {
  const BottomSheetTypeLeaveWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<TypeLeaveEnum> onChange;

  @override
  State<BottomSheetTypeLeaveWidget> createState() => _BottomSheetTypeLeaveWidgetState();
}

class _BottomSheetTypeLeaveWidgetState extends State<BottomSheetTypeLeaveWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: TypeLeaveEnum.values
          .where((e) => e != TypeLeaveEnum.total)
          .mapIndexed(
            (index, element) => GestureDetector(
              onTap: () => setOnChange(
                type: element,
              ),
              child: ContainerBorder(
                padding: SpacingUnit.x3,
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
                      element.configTypeLeaveEnum,
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
    );
  }

  setOnChange({required TypeLeaveEnum type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
