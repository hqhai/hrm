import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemWorkShift extends StatefulWidget {
  final ValueChanged<List<WorkShiftRegisteredDetail>> workShiftSettings;
  final List<WorkShiftRegisteredDetail> workShiftSettingsOld;

  const ItemWorkShift({
    super.key,
    required this.workShiftSettings,
    required this.workShiftSettingsOld,
  });

  @override
  State<ItemWorkShift> createState() => _ItemWorkShiftState();
}

class _ItemWorkShiftState extends State<ItemWorkShift> {
  List<WorkShiftRegisteredDetail> listWorkShifts = [];

  @override
  void initState() {
    listWorkShifts = widget.workShiftSettingsOld;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LeaveShiftBloc, LeaveShiftState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (state.keys.isEmpty)
              Text(
                appLocalizations.youDoNotHaveAShift,
                style: TextStyle(
                  color: colors.error,
                  fontSize: SpacingUnit.x3,
                ),
              ),
            if (state.keys.isNotEmpty) ...[
              Padding(
                padding: const EdgeInsets.only(top: SpacingUnit.x2),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: appLocalizations.chooseWorkShift,
                        style: TextStyle(
                            fontSize: SpacingUnit.x4,
                            color: colors.text,
                            fontWeight: FontWeight.w600),
                      ),
                      TextSpan(
                        text: "*",
                        style: TextStyle(
                          color: colors.error,
                          fontSize: SpacingUnit.x4,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: state.keys.mapIndexed(
                  (index, element) {
                    final date = DateTime.fromMicrosecondsSinceEpoch(element);
                    final listKey = state.mapKeyDate[element] ?? [];
                    return !checkSE(
                      dateInt: element,
                      keyDate: state.keys,
                    )
                        ? ContainerBorder(
                            borderColors: colors.outline.withOpacity(0.4),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpacingUnit.x4,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        appLocalizations.date,
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x4,
                                        ),
                                      ),
                                      Text(
                                        formatYMD(date.toString()),
                                        style: TextStyle(
                                          color: colors.text,
                                          fontSize: SpacingUnit.x4,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: listKey.map(
                                      (e) {
                                        final workShift = state.workShifts[e] ??
                                            WorkShiftRegisteredDetail(
                                                workDate: DateTime.now());
                                        return ContainerBorder(
                                          borderColors:
                                              colors.outline.withOpacity(0.4),
                                          width: width,
                                          paddingVertical: 0,
                                          child: CheckboxListTile(
                                            controlAffinity:
                                                ListTileControlAffinity.leading,
                                            value: _checkValue(workShift)
                                                .isNotEmpty,
                                            onChanged: (value) => _onChange(
                                              value: value,
                                              workShift: workShift,
                                              dateInt: element,
                                              keyDate: state.keys,
                                              dataWorkShifts: state.workShifts,
                                              workShiftSettings:
                                                  (List<WorkShiftRegisteredDetail>
                                                          data) =>
                                                      widget.workShiftSettings
                                                          .call(data),
                                              currentListWorkShifts:
                                                  listWorkShifts,
                                            ),
                                            title: Text(
                                              '${strSeconds(workShift.startTime)} - ${strSeconds(workShift.endTime)}',
                                              style: TextStyle(
                                                color: colors.text,
                                                fontSize: SpacingUnit.x4,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                ).toList(),
              ),
            ],
          ],
        );
      },
    );
  }

  Iterable<WorkShiftRegisteredDetail> _checkValue(
      WorkShiftRegisteredDetail workShift) {
    return listWorkShifts.where((element) => element == workShift);
  }

  _onChange({
    bool? value,
    required WorkShiftRegisteredDetail workShift,
    required int dateInt,
    required List<int> keyDate,
    required Map<String, WorkShiftRegisteredDetail> dataWorkShifts,
    required ValueChanged<List<WorkShiftRegisteredDetail>> workShiftSettings,
    required List<WorkShiftRegisteredDetail> currentListWorkShifts,
  }) {
    final checkType = keyDate.length > 1;
    if (checkType) {
      final isEnable = currentListWorkShifts.contains(workShift);
      final listWorkShift = dataWorkShifts.values.toList();
      if (!isEnable) {
        _addWorkShift(
            currentListWorkShifts: currentListWorkShifts,
            listWorkShift,
            workShift,
            workShiftSettings);
      } else {
        _delete(
          currentListWorkShifts: currentListWorkShifts,
          workShift: workShift,
          workShiftSettings: workShiftSettings,
          listWorkShift: listWorkShift,
        );
      }
    }
  }

  void _delete({
    required List<WorkShiftRegisteredDetail> currentListWorkShifts,
    required WorkShiftRegisteredDetail workShift,
    required ValueChanged<List<WorkShiftRegisteredDetail>> workShiftSettings,
    required List<WorkShiftRegisteredDetail> listWorkShift,
  }) {
    final checkFistDate =
        listWorkShift.first.workDate.compareTo(workShift.workDate) == 0;
    final checkEndDate =
        listWorkShift.last.workDate.compareTo(workShift.workDate) == 0;
    if (checkFistDate) {
      final data = _deleteTime(
        index1: 0,
        index2: 1,
        workShift: workShift,
        currentListWorkShifts: currentListWorkShifts,
        listWorkShift: listWorkShift,
        isEnd: false,
      );
      workShiftSettings.call(data);
      setState(() {
        listWorkShifts = data;
      });
    } else if (checkEndDate) {
      final data = _deleteTime(
          index1: listWorkShift.length - 1,
          index2: listWorkShift.length - 2,
          workShift: workShift,
          currentListWorkShifts: currentListWorkShifts,
          listWorkShift: listWorkShift,
          isEnd: true);
      workShiftSettings.call(data);
      setState(() {
        listWorkShifts = data;
      });
    }
  }

  List<WorkShiftRegisteredDetail> _deleteTime({
    required int index1,
    required int index2,
    required WorkShiftRegisteredDetail workShift,
    required List<WorkShiftRegisteredDetail> currentListWorkShifts,
    required List<WorkShiftRegisteredDetail> listWorkShift,
    required bool isEnd,
  }) {
    int currentIndex = listWorkShift.indexOf(workShift);
    if (currentIndex == index1) {
      List<WorkShiftRegisteredDetail> listData = currentListWorkShifts
          .where((element) => element != listWorkShift[index1])
          .toList();
      return listData;
    } else {
      final listData = currentListWorkShifts
          .where((element) => isEnd
              ? listWorkShift.first.workDate.compareTo(element.workDate) == 0
              : listWorkShift.last.workDate.compareTo(element.workDate) == 0)
          .toList();
      return listData;
    }
  }

  void _addWorkShift(
    List<WorkShiftRegisteredDetail> listWorkShift,
    WorkShiftRegisteredDetail workShift,
    ValueChanged<List<WorkShiftRegisteredDetail>> workShiftSettings, {
    required List<WorkShiftRegisteredDetail> currentListWorkShifts,
  }) {
    List<WorkShiftRegisteredDetail> listWorkShiftsSelect =
        _getListWorkShiftsSelect(
                currentListWorkShifts: currentListWorkShifts,
                listWorkShift,
                workShift)
            .toList();
    workShiftSettings.call(listWorkShiftsSelect);
    setState(() {
      listWorkShifts = listWorkShiftsSelect;
    });
  }

  Iterable<WorkShiftRegisteredDetail> _getListWorkShiftsSelect(
    List<WorkShiftRegisteredDetail> listWorkShift,
    WorkShiftRegisteredDetail workShift, {
    required List<WorkShiftRegisteredDetail> currentListWorkShifts,
  }) {
    final checkFistDate =
        listWorkShift.first.workDate.compareTo(workShift.workDate) == 0;
    final checkEndDate =
        listWorkShift.last.workDate.compareTo(workShift.workDate) == 0;
    int currentIndex = listWorkShift.indexOf(workShift);
    if (checkFistDate) {
      return addFistDate(
          currentListWorkShifts, listWorkShift, currentIndex, workShift);
    } else if (checkEndDate) {
      return _addEndDate(
          listWorkShift, currentListWorkShifts, currentIndex, workShift);
    } else {
      return [];
    }
  }

  List<WorkShiftRegisteredDetail> _addEndDate(
      List<WorkShiftRegisteredDetail> listWorkShift,
      List<WorkShiftRegisteredDetail> currentListWorkShifts,
      int currentIndex,
      WorkShiftRegisteredDetail workShift) {
    int startIndex = listWorkShift.length - 2;
    int endIndex = listWorkShift.length - 1;
    if (currentListWorkShifts.isNotEmpty) {
      final items = listWorkShift.sublist(
        listWorkShift.indexOf(currentListWorkShifts.first),
        currentIndex + 1,
      );
      return items;
    } else {
      if (currentIndex == endIndex) {
        final items = listWorkShift.sublist(
          startIndex,
          endIndex + 1,
        );
        return items;
      } else {
        return [workShift];
      }
    }
  }

  List<WorkShiftRegisteredDetail> addFistDate(
      List<WorkShiftRegisteredDetail> currentListWorkShifts,
      List<WorkShiftRegisteredDetail> listWorkShift,
      int currentIndex,
      WorkShiftRegisteredDetail workShift) {
    int startIndex = 0;
    int endIndex = startIndex + 1;
    if (currentListWorkShifts.isNotEmpty) {
      int lastIndex = listWorkShift.indexOf(currentListWorkShifts.last);
      if (lastIndex == endIndex) {
        final items = listWorkShift.sublist(
          startIndex,
          endIndex + 1,
        );
        return items;
      } else {
        final items = listWorkShift.sublist(
          currentIndex,
          lastIndex + 1,
        );
        return items;
      }
    } else {
      if (currentIndex == startIndex) {
        final items = listWorkShift.sublist(
          startIndex,
          endIndex + 1,
        );
        return items;
      } else {
        return [workShift];
      }
    }
  }

  //  else if (checkEndDate) {
  //   final data =
  //       _selectEndDate(currentListWorkShifts, listWorkShift, workShift);
  //   return data;
  // } else {
  //   return [];
  // }
  // }
  List<WorkShiftRegisteredDetail> getWorkShiftsAlikeDate(
      LeaveShiftState state, WorkShiftRegisteredDetail workShift) {
    return state.workShifts.values
        .where((element) =>
            element.workDate.microsecondsSinceEpoch ==
            workShift.workDate.microsecondsSinceEpoch)
        .toList();
  }

  bool checkSE({required int dateInt, required List<int> keyDate}) {
    keyDate.sort();
    return keyDate.first < dateInt && keyDate.last > dateInt;
  }

  bool checkShift(
      {required WorkShiftRegisteredDetail workShiftDetail,
      required WorkShiftRegisteredDetail workShift}) {
    return workShiftDetail.workShiftDetailId == workShift.workShiftDetailId &&
        workShiftDetail.workDate.microsecond ==
            workShift.workDate.microsecond &&
        workShiftDetail.workShiftSettingDetailId ==
            workShift.workShiftSettingDetailId;
  }

  bool checkAnyList({
    required WorkShiftRegisteredDetail workShift,
  }) {
    return listWorkShifts.any((element) =>
        element.workShiftDetailId == workShift.workShiftDetailId &&
        element.workDate.microsecond == workShift.workDate.microsecond &&
        element.workShiftSettingDetailId == workShift.workShiftSettingDetailId);
  }
}
