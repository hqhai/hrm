import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetDeliveryWidget extends StatefulWidget {
  const BottomSheetDeliveryWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<RequisitionDeliveryTypeEnum> onChange;

  @override
  State<BottomSheetDeliveryWidget> createState() => _BottomSheetDeliveryWidgetState();
}

class _BottomSheetDeliveryWidgetState extends State<BottomSheetDeliveryWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.4,
      color: colors.surface,
      child: Center(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.4,
              child: ListView.builder(
                itemCount: RequisitionDeliveryTypeEnum.values.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => addType(type: RequisitionDeliveryTypeEnum.values[index]),
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
                          RequisitionDeliveryTypeEnum.values[index].configDeliveryTypeName,
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
          ],
        ),
      ),
    );
  }

  addType({required RequisitionDeliveryTypeEnum type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
