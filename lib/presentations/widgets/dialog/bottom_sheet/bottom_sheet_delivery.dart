import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetDeliveryWidget extends StatefulWidget {
  const BottomSheetDeliveryWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<RequisitionDeliveryTypeEnum> onChange;

  @override
  State<BottomSheetDeliveryWidget> createState() =>
      _BottomSheetDeliveryWidgetState();
}

class _BottomSheetDeliveryWidgetState extends State<BottomSheetDeliveryWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(
        SpacingUnit.x5,
      ),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: RequisitionDeliveryTypeEnum.values
              .mapIndexed(
                (index, element) => GestureDetector(
                  onTap: () => addType(type: element),
                  child: ContainerBorder(
                    padding: SpacingUnit.x2,
                    marginTop: SpacingUnit.x2,
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
                          element.configDeliveryTypeName,
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
              .toList()),
    );
  }

  addType({required RequisitionDeliveryTypeEnum type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
