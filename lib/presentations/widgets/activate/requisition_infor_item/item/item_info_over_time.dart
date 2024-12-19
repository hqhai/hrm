import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:flutter/material.dart';

class ItemInfoOverTime extends StatelessWidget {
  const ItemInfoOverTime({super.key, this.data});
  final RequisitionOverTime? data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  formatYMD(data?.date.toString()),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  strTimeFromInt(data?.suggestTime.toInt() ?? 0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${data?.rate}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF000000),
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          height: 0.5,
          color: Color(0xFFE5E7E8),
        )
      ],
    );
  }
}
