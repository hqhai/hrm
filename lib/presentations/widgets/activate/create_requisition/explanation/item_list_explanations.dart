import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/requisition/requisition/explanation.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_in_list_explanation.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ListExplanationsWidget extends StatefulWidget {
  const ListExplanationsWidget({
    super.key,
    required this.title,
    required this.callback,
    this.explanations = const [],
    required this.changeExplanations,
    this.error = '',
  });

  final String error;
  final String title;
  final VoidCallback callback;
  final List<Explanation> explanations;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleRequired(
                title: widget.title,
                requiredValidate: true,
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
          if (widget.error.isNotEmpty)
            Text(
              widget.error,
              style: TextStyle(
                color: colors.error,
                fontSize: SpacingUnit.x3,
              ),
            ),
          Column(
            children: widget.explanations
                .mapIndexed(
                  (index, element) => ItemInListExplanation(
                    callBackDelete: () => _deleteExplanation(index),
                    changeExplanation: (value) => _setExplanation(value, index),
                    explanation: element,
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  _setExplanation(Explanation value, int index) {
    final explanations = widget.explanations;
    setState(() {
      explanations[index] = value;
      widget.changeExplanations.call(explanations);
    });
  }

  _deleteExplanation(int index) {
    final explanations = widget.explanations;
    setState(() {
      explanations.removeAt(index);
      widget.changeExplanations.call(explanations);
    });
  }
}
