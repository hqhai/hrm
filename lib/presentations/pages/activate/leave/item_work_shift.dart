import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemWorkShift extends StatefulWidget {
  const ItemWorkShift({
    super.key,
    required this.ids,
  });

  final ValueChanged<List<String>> ids;

  @override
  State<ItemWorkShift> createState() => _ItemWorkShiftState();
}

class _ItemWorkShiftState extends State<ItemWorkShift> {
  List<String> ids = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery
        .of(context)
        .size
        .width;
    return BlocConsumer<LeaveShiftBloc, LeaveShiftState>(
      listener: (context, state) => _listener(state),
      listenWhen: (previous, current) => previous.keys != current.keys,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: state.keys.mapIndexed(
                (index, element) {
              final date = DateTime.fromMicrosecondsSinceEpoch(element);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatYMD(date.toString()),
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x3, fontWeight: FontWeight.w600),
                  ),
                  Column(
                    children: state.mapKeyDate[element] != null
                        ? state.mapKeyDate[element]!.map((e) {
                      final workShift = state.workShifts[e];
                      return ContainerBorder(
                        borderColors: colors.outline.withOpacity(0.4),
                        width: width,
                        padding: 0,
                        child: CheckboxListTile(
                          value: check(dateInt: element, keyDate: state.keys, id: e),
                          onChanged: (value) =>
                              _onChange(
                                  value: value,
                                  id: e,
                                  dateInt: element,
                                  keyDate: state.keys,
                                  state: state),
                          title: Text(
                            '${strSeconds(workShift?.startTime)} - ${strSeconds(
                                workShift?.endTime)}',
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        ),
                      );
                    }).toList()
                        : [],
                  ),
                ],
              );
            },
          ).toList(),
        );
      },
    );
  }

  _onChange({bool? value, required String id, required int dateInt, required List<
      int> keyDate, required LeaveShiftState state}) {
    if (!ids.contains(id)) {
      setState(() {
        ids.add(id);
        widget.ids.call(ids);
      });
    } else if (ids.contains(id)) {
      setState(() {
        ids.remove(id);
        widget.ids.call(ids);
      });
    }
  }

  bool check({required int dateInt, required List<int> keyDate, required String id}) {
    final checkSE = keyDate.first < dateInt && keyDate.last > dateInt;
    final checkId = ids.contains(id);
    return checkSE || checkId;
  }

  _listener(LeaveShiftState state) {
    for (var element in state.keys) {
      if (state.keys.first < element && state.keys.last > element) {
        state.mapKeyDate[element]?.forEach((e) {
          setState(() {
            ids.add(state.workShifts[e]?.workShiftSettingDetailId ?? "");
          });
        });
      }
    }
  }
}