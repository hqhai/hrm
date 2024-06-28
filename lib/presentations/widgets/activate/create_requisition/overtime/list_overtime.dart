import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/overtime/over_time_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListOverTime extends StatefulWidget {
  final List<RequisitionOverTime> requisitionOverTimes;
  final ValueChanged<List<RequisitionOverTime>> onChangeList;
  final String error, title;

  const ListOverTime(
      {super.key,
      this.requisitionOverTimes = const [],
      required this.onChangeList,
      this.error = '',
      required this.title,});

  @override
  State<ListOverTime> createState() => _ListOverTimeState();
}

class _ListOverTimeState extends State<ListOverTime> {

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w800,
          ),
        ),
        ContainerBorder(
          width: width,
          borderColors: colors.surface,
          child: Column(
            children:  widget.requisitionOverTimes
                .mapIndexed(
                  (index, element) => GestureDetector(
                    onTap: () => _getOverTimeInList(context,  widget.requisitionOverTimes[index], index),
                    child: ItemListOverTime(
                      requisitionOverTime: widget.requisitionOverTimes[index],
                      index: index,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
        if (widget.error != '')
          Padding(
            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1),
            child: Text(
              widget.error,
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          ),
      ],
    );
  }

  _getOverTimeInList(BuildContext context, RequisitionOverTime requisitionOverTime, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: OverTimeAddDialog(
            requisitionOverTime: requisitionOverTime,
            onChangeOverTimes: (value) => setEdit(value, index),
          ),
        );
      },
    );
  }

  setEdit(RequisitionOverTime value, int index) {
    final listOverTimes = widget.requisitionOverTimes;
    setState(() {
      listOverTimes[index] = RequisitionOverTime(
          endTime: value.endTime,
          suggestTime: value.suggestTime,
          note: value.note,
          startTime: value.startTime,
          date: value.date);
      widget.onChangeList.call(listOverTimes);
    });
  }
}
