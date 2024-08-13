import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';

import 'package:flutter/material.dart';

import 'package:themes/themes.dart';

class GenderBottomSheetWidget extends StatefulWidget {
  const GenderBottomSheetWidget({
    super.key,
    required this.onChange,
    this.gender = GenderEnum.other,
  });

  final ValueChanged<GenderEnum> onChange;
  final GenderEnum gender;

  @override
  State<GenderBottomSheetWidget> createState() => _GenderBottomSheetWidgetState();
}

class _GenderBottomSheetWidgetState extends State<GenderBottomSheetWidget> {
  GenderEnum gender = GenderEnum.other;

  @override
  void initState() {
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: colors.text.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: GenderEnum.values
              .map(
                (e) => GestureDetector(
                  onTap: () => _onChange(e),
                  child: ContainerBorder(
                    width: width,
                    borderColors: e == gender ? colors.blue : colors.background,
                    backgroundColors: e == gender ? colors.blue : colors.background,
                    child: Text(
                      e.configGenderName,
                      style: TextStyle(
                        color: e == gender ? colors.background : colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  setOnChange() {}

  _onChange(GenderEnum e) {
    widget.onChange.call(e);
    Navigator.of(context).pop();
  }
}
