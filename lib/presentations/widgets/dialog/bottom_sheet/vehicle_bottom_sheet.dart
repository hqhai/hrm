import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class VehicleBottomSheetWidget extends StatefulWidget {
  const VehicleBottomSheetWidget({
    super.key,
    required this.onChange,
    this.vehicle = VehicleTypeEnum.motorbike,
  });

  final ValueChanged<VehicleTypeEnum> onChange;
  final VehicleTypeEnum vehicle;

  @override
  State<VehicleBottomSheetWidget> createState() =>
      _VehicleBottomSheetWidgetState();
}

class _VehicleBottomSheetWidgetState extends State<VehicleBottomSheetWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: colors.text.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: VehicleTypeEnum.values
              .map(
                (e) => GestureDetector(
                  onTap: () => _onChange(e),
                  child: ContainerBorder(
                    width: width,
                    borderColors:
                        e == widget.vehicle ? colors.blue : colors.background,
                    backgroundColors:
                        e == widget.vehicle ? colors.blue : colors.background,
                    child: Text(
                      e.configVehicleTypeName,
                      style: TextStyle(
                        color: e == widget.vehicle
                            ? colors.background
                            : colors.text,
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

  _onChange(VehicleTypeEnum e) {
    widget.onChange.call(e);
    Navigator.of(context).pop();
  }
}
