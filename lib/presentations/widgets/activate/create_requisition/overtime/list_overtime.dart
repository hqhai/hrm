import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/requisition_over_time.dart';
import 'package:base_app/presentations/widgets/dialog/overtime/over_time_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListOverTime extends StatefulWidget {
  final List<RequisitionOverTime> requisitionOverTimes;
  final ValueChanged<List<RequisitionOverTime>> onChangeList;
  final String error, title;
  final bool checkExplanation;
  final List<bool> checkTypeContainer;
  final ValueChanged<List<bool>> changeTypeContainer;
  final VoidCallback callback;

  const ListOverTime(
      {super.key,
      this.requisitionOverTimes = const [],
      required this.onChangeList,
      this.error = '',
      required this.title,
      this.checkExplanation = false,
      this.checkTypeContainer = const [],
      required this.changeTypeContainer,
      required this.callback});

  @override
  State<ListOverTime> createState() => _ListOverTimeState();
}

class _ListOverTimeState extends State<ListOverTime> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x4,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () => widget.callback.call(),
                child: Icon(
                  Icons.add,
                  size: SpacingUnit.x8,
                  color: colors.success,
                ),
              )
            ],
          ),
          SizedBox(
            width: width,
            child: Column(
              children: widget.requisitionOverTimes
                  .mapIndexed(
                    (index, element) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                      child: OverTimeAddDialog(
                        callBackTypeContainer: () => setTypeContainer(index),
                        checkTypeContainer: widget.checkTypeContainer[index],
                        callBack: () => deleteRequisitionOverTime(index),
                        onChangeOverTimes: (value) => setEdit(value: value, index: index),
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
      ),
    );
  }

  setEdit({required RequisitionOverTime value, required int index}) {
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

  setTypeContainer(int index) {
    final listType = widget.checkTypeContainer;
    setState(() {
      listType[index] = !listType[index];
      widget.changeTypeContainer.call(listType);
    });
  }

  deleteRequisitionOverTime(int index) {
    final listOverTimes = widget.requisitionOverTimes;
    final typeContainer = widget.checkTypeContainer;
    setState(() {
      setState(() {
        typeContainer.removeAt(index);
        listOverTimes.removeAt(index);
        widget.changeTypeContainer(typeContainer);
        widget.onChangeList.call(listOverTimes);
      });
    });
  }
}
