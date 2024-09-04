import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/overtime/over_time_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListOverTime extends StatefulWidget {
  final List<RequisitionOverTime> requisitionOverTimes;
  final ValueChanged<List<RequisitionOverTime>> onChangeList;
  final String error, title;
  final bool checkExplanation;
  final VoidCallback callback;
  final bool requiredValidate;
  final bool checkUpdate;

  const ListOverTime(
      {super.key,
      this.requisitionOverTimes = const [],
      required this.onChangeList,
      this.error = '',
      required this.title,
      this.checkExplanation = false,
      required this.callback,
      this.requiredValidate = false,
      required this.checkUpdate});

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
              TitleRequired(
                title: widget.title,
                requiredValidate: widget.requiredValidate,
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
                      padding:
                          const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                      child: OverTimeAddDialog(
                        checkUpdate: widget.checkUpdate,
                        requisitionOverTime: widget.requisitionOverTimes[index],
                        callBack: () => deleteRequisitionOverTime(index),
                        onChangeOverTimes: (value) =>
                            setEdit(value: value, index: index),
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
          date: value.date,
          isChecking: value.isChecking,
          overtimeDay: value.overtimeDay);
      widget.onChangeList.call(listOverTimes);
    });
  }

  deleteRequisitionOverTime(int index) {
    final listOverTimes = widget.requisitionOverTimes;
    setState(() {
      setState(() {
        listOverTimes.removeAt(index);
        widget.onChangeList.call(listOverTimes);
      });
    });
  }
}
