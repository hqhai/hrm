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
  const ItemWorkShift({
    super.key,
    required this.workShiftSettings,
    required this.workShiftSettingsOld,
  });

  final ValueChanged<List<WorkShiftRegisteredDetail>> workShiftSettings;
  final List<WorkShiftRegisteredDetail> workShiftSettingsOld;

  @override
  State<ItemWorkShift> createState() => _ItemWorkShiftState();
}

class _ItemWorkShiftState extends State<ItemWorkShift> {
  List<WorkShiftRegisteredDetail> workShifts = [];

  @override
  void initState() {
    workShifts = widget.workShiftSettingsOld;
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
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            WorkShiftRegisteredDetail(workDate: DateTime.now());
                                        return ContainerBorder(
                                          borderColors: colors.outline.withOpacity(0.4),
                                          width: width,
                                          paddingVertical: 0,
                                          child: CheckboxListTile(
                                            controlAffinity: ListTileControlAffinity.leading,
                                            value: check(
                                                dateInt: element,
                                                keyDate: state.keys,
                                                workShift: workShift),
                                            onChanged: (value) => _onChange(
                                                value: value,
                                                workShift: workShift,
                                                dateInt: element,
                                                keyDate: state.keys,
                                                state: state),
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

  _onChange(
      {bool? value,
      required WorkShiftRegisteredDetail workShift,
      required int dateInt,
      required List<int> keyDate,
      required LeaveShiftState state}) {
    final checkType = keyDate.length > 1;
    if (checkType) {
      /// check phải ngày cuối hoặc đầu không
      final firstOrLast = workShift.workDate.microsecondsSinceEpoch == state.keys.first ||
          workShift.workDate.microsecondsSinceEpoch == state.keys.last;

      ///list ca
      final listWorkShift = state.workShifts.values.toList();
      final workShiftsAlikeDate = state.workShifts.values
          .where((element) =>
              element.workDate.microsecondsSinceEpoch == workShift.workDate.microsecondsSinceEpoch)
          .toList();

      ///Không phải ca thuộc ngày đầu và cuối th cho hết vào list
      for (var element in listWorkShift) {
        final notFirstOrLast = element.workDate.microsecondsSinceEpoch != state.keys.first &&
            element.workDate.microsecondsSinceEpoch != state.keys.last;
        if (!checkAnyList(workShift: element) && notFirstOrLast) {
          setState(() {
            workShifts.add(element);
          });
        }
      }

      ///Thêm ca
      if (!checkAnyList(workShift: workShift) && firstOrLast) {
        for (var element in workShiftsAlikeDate) {
          ///Xử lý chọn ca đầu thì lấy luôn các ca sau
          if (element.startTime > workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.first) {
            setState(() {
              if (!checkAnyList(workShift: element)) {
                workShifts.add(element);
              }
            });

            ///Xử lý chọn là ca cuối thì lấy luôn các ca trước
          } else if (element.startTime < workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.last) {
            setState(() {
              if (!checkAnyList(workShift: element)) {
                workShifts.add(element);
              }
            });
          }
        }
        setState(() {
          workShifts.add(workShift);
        });

        ///Xóa ca
      } else if (checkAnyList(workShift: workShift) && firstOrLast) {
        for (var element in workShiftsAlikeDate) {
          if (element.startTime < workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.first) {
            final listLast = workShiftsAlikeDate
                .where((e) =>
                    e.workDate.microsecondsSinceEpoch < element.workDate.microsecondsSinceEpoch)
                .toList();
            setState(() {
              if (listLast.isNotEmpty) {
                workShifts = workShifts
                    .where((e) => !checkShift(workShift: element, workShiftDetail: e))
                    .toList();
              } else {
                workShifts.clear();
              }
            });
            setState(() {
              workShifts = workShifts
                  .where((e) => !checkShift(workShift: element, workShiftDetail: e))
                  .toList();
            });
          } else if (element.startTime > workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.last) {
            final listLast = workShiftsAlikeDate
                .where((e) =>
                    e.workDate.microsecondsSinceEpoch > element.workDate.microsecondsSinceEpoch)
                .toList();
            setState(() {
              if (listLast.isNotEmpty) {
                workShifts = workShifts
                    .where((e) => !checkShift(workShift: element, workShiftDetail: e))
                    .toList();
              } else {
                workShifts.clear();
              }
            });
          }
        }
        setState(() {
          workShifts = workShifts
              .where((e) => !checkShift(workShift: workShift, workShiftDetail: e))
              .toList();
        });
      }
    } else {
      if (!checkAnyList(workShift: workShift)) {
        setState(() {
          workShifts.add(workShift);
        });
      } else if (checkAnyList(workShift: workShift)) {
        setState(() {
          workShifts = workShifts
              .where((e) => !checkShift(workShift: workShift, workShiftDetail: e))
              .toList();
        });
      }
    }

    ///Sắp xếp ca theo thứ tự ngày và giờ bắt đầu
    if (workShifts.isNotEmpty) {
      workShifts.sort((a, b) {
        int dateComparison = a.workDate.compareTo(b.workDate);
        if (dateComparison != 0) {
          return dateComparison;
        } else {
          return a.startTime.compareTo(b.startTime);
        }
      });
    }

    ///check xem đã lấy ngày đầu cuối chưa?
    final checkS =
        workShifts.any((element) => element.workDate.microsecondsSinceEpoch == state.keys.first);
    final checkE =
        workShifts.any((element) => element.workDate.microsecondsSinceEpoch == state.keys.last);
    if (checkS && checkE) {
      widget.workShiftSettings.call(workShifts);
    } else {
      final list = workShifts
          .where((element) =>
              element.workDate.microsecondsSinceEpoch == state.keys.last ||
              element.workDate.microsecondsSinceEpoch == state.keys.first)
          .toList();
      widget.workShiftSettings.call(list);
    }
  }

  bool checkSE({required int dateInt, required List<int> keyDate}) {
    keyDate.sort();
    return keyDate.first < dateInt && keyDate.last > dateInt;
  }

  ///check xem có tick không
  bool check(
      {required int dateInt,
      required List<int> keyDate,
      required WorkShiftRegisteredDetail workShift}) {
    keyDate.sort();
    final checkSE = keyDate.first < dateInt && keyDate.last > dateInt;
    final checkId = checkAnyList(workShift: workShift);
    return checkSE || checkId;
  }

  bool checkShift(
      {required WorkShiftRegisteredDetail workShiftDetail,
      required WorkShiftRegisteredDetail workShift}) {
    return workShiftDetail.workShiftDetailId == workShift.workShiftDetailId &&
        workShiftDetail.workDate.microsecond == workShift.workDate.microsecond &&
        workShiftDetail.workShiftSettingDetailId == workShift.workShiftSettingDetailId;
  }

  bool checkAnyList({
    required WorkShiftRegisteredDetail workShift,
  }) {
    return workShifts.any((element) =>
        element.workShiftDetailId == workShift.workShiftDetailId &&
        element.workDate.microsecond == workShift.workDate.microsecond &&
        element.workShiftSettingDetailId == workShift.workShiftSettingDetailId);
  }
}
