import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/domain/entities/reqisition/work_shift_registered_details.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_in_list_explanation.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListExplanationsWidget extends StatefulWidget {
  const ListExplanationsWidget({
    super.key,
    required this.title,
    required this.callback,
    this.explanations = const [],
    this.checkTypeContainer = const [],
    required this.changeTypeContainer,
    required this.changeExplanations,
  });

  final String title;
  final VoidCallback callback;
  final List<Explanation> explanations;
  final List<bool> checkTypeContainer;
  final ValueChanged<List<bool>> changeTypeContainer;
  final ValueChanged<List<Explanation>> changeExplanations;

  @override
  State<ListExplanationsWidget> createState() => _ListExplanationsWidgetState();
}

class _ListExplanationsWidgetState extends State<ListExplanationsWidget> {
  List<WorkShiftRegisteredDetail> workShifts = [];

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x4),
      child: Column(
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
          Column(
            children: widget.explanations
                .mapIndexed(
                  (index, element) => ItemInListExplanation(
                    callBackDelete: () => _deleteExplanation(index),
                    workShifts: workShifts,
                    changeExplanation: (value) => _setExplanation(value, index),
                    callBack: () => setTypeContainer(index),
                    checkTypeContainer: widget.checkTypeContainer[index],
                    explanation: element,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  setTypeContainer(int index) {
    final listType = widget.checkTypeContainer;
    setState(() {
      listType[index] = !listType[index];
      widget.changeTypeContainer.call(listType);
    });
  }

  _setExplanation(Explanation value, int index) {
    final explanations = widget.explanations;
    setState(() {
      explanations[index] = value;
      widget.changeExplanations.call(explanations);
    });
  }

  _deleteExplanation(int index) {
    final listType = widget.checkTypeContainer;
    final explanations = widget.explanations;
    setState(() {
      explanations.removeAt(index);
      listType[index] = !listType[index];
      widget.changeTypeContainer.call(listType);
      widget.changeExplanations.call(explanations);
    });
  }
}
