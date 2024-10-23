import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/work_shift_registered_details.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/late_early/minutes_in_shift.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class WorkShiftLateEarly extends StatefulWidget {
  const WorkShiftLateEarly({
    super.key,
    required this.workShiftSettings,
    this.type = RequisitionTypeEnum.leaveHalfDayToOneDay,
    required this.typeLE,
    required this.workShiftSettingsOld,
  });

  final ValueChanged<List<WorkShiftRegisteredDetail>> workShiftSettings;
  final RequisitionTypeEnum type;
  final EditTimekeeping typeLE;
  final List<WorkShiftRegisteredDetail> workShiftSettingsOld;

  @override
  State<WorkShiftLateEarly> createState() => _WorkShiftLateEarlyState();
}

class _WorkShiftLateEarlyState extends State<WorkShiftLateEarly> {
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
                child: TitleRequired(
                  title: appLocalizations.chooseWorkShift,
                  requiredValidate: true,
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: state.keys.mapIndexed(
                  (index, element) {
                    final listKey = state.mapKeyDate[element] ?? [];
                    return !checkSE(dateInt: element, keyDate: state.keys)
                        ? Column(
                            children: listKey.map(
                              (e) {
                                final workShift = state.workShifts[e] ??
                                    WorkShiftRegisteredDetail(workDate: DateTime.now());
                                return Column(
                                  children: [
                                    ContainerBorder(
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
                                    ),
                                    if (check(
                                        dateInt: element,
                                        keyDate: state.keys,
                                        workShift: workShift))
                                      MinutesInShift(
                                        type: widget.typeLE,
                                        minutes: numberTimeShift(
                                          workShift: workShifts.firstWhere(
                                                (e) => checkShift(
                                                workShiftDetail: e, workShift: workShift),
                                          ),
                                        ),
                                        changeMinutes: (value) =>
                                            changeMinutes(value: value, workShift: workShift),
                                      ),
                                  ],
                                );
                              },
                            ).toList(),
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

  int numberTimeShift({required WorkShiftRegisteredDetail workShift}) {
    final listData = workShifts
        .where((element) =>
            element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
            element.workShiftDetailId == workShift.workShiftDetailId &&
            element.workDate == workShift.workDate)
        .toList();
    if (listData.isNotEmpty) {
      return listData.first.numberTime;
    }
    return 0;
  }

  _onChange(
      {bool? value,
      required WorkShiftRegisteredDetail workShift,
      required int dateInt,
      required List<int> keyDate,
      required LeaveShiftState state}) {
    final checkType = widget.type == RequisitionTypeEnum.leaveFiveDaysOrMore ||
        widget.type == RequisitionTypeEnum.leaveTwoDayToFourDay ||
        widget.type == RequisitionTypeEnum.bussiness;
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
        if (!workShifts.any((e) =>
                element.workDate.microsecond == e.workDate.microsecond &&
                element.workShiftSettingDetailId == e.workShiftSettingDetailId &&
                element.workShiftDetailId == e.workShiftDetailId) &&
            notFirstOrLast) {
          setState(() {
            workShifts.add(element);
          });
        }
      }

      ///Thêm ca
      if (!workShifts.any((element) =>
              element.workDate.microsecond == workShift.workDate.microsecond &&
              element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
              element.workShiftDetailId == workShift.workShiftDetailId) &&
          firstOrLast) {
        for (var element in workShiftsAlikeDate) {
          ///Xử lý chọn ca đầu thì lấy luôn các ca sau
          if (element.startTime > workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.first) {
            setState(() {
              workShifts.add(element);
            });

            ///Xử lý chọn là ca cuối thì lấy luôn các ca trước
          } else if (element.startTime < workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.last) {
            setState(() {
              workShifts.add(element);
            });
          }
        }
        setState(() {
          workShifts.add(workShift);
        });

        ///Xóa ca
      } else if (workShifts.any((element) =>
              element.workDate.microsecond == workShift.workDate.microsecond &&
              element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
              element.workShiftDetailId == workShift.workShiftDetailId) &&
          firstOrLast) {
        for (var element in workShiftsAlikeDate) {
          if (element.startTime < workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.first) {
            setState(() {
              workShifts = workShifts
                  .where((e) => !checkShift(workShift: element, workShiftDetail: e))
                  .toList();
            });
          } else if (element.startTime > workShift.startTime &&
              element.workDate.microsecondsSinceEpoch == state.keys.last) {
            setState(() {

              workShifts = workShifts
                  .where((e) => !checkShift(workShift: element, workShiftDetail: e))
                  .toList();
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
      if (!workShifts.any((element) =>
          element.workDate.microsecond == workShift.workDate.microsecond &&
          element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
          element.workShiftDetailId == workShift.workShiftDetailId)) {
        setState(() {
          workShifts.add(workShift);
        });
      } else if (workShifts.any((element) =>
          element.workDate.microsecond == workShift.workDate.microsecond &&
          element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
          element.workShiftDetailId == workShift.workShiftDetailId)) {
        setState(() {
          final indexShift = workShifts.indexWhere((element) =>
              element.workDate.microsecond == workShift.workDate.microsecond &&
              element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
              element.workShiftDetailId == workShift.workShiftDetailId);
          workShifts.removeAt(indexShift);
        });
      }
    }

    ///Sắp xếp ca theo thứ tự ngày và giờ bắt đầu
    workShifts.sort((a, b) {
      int dateComparison = a.workDate.compareTo(b.workDate);
      if (dateComparison != 0) {
        return dateComparison;
      } else {
        return a.startTime.compareTo(b.startTime);
      }
    });
    widget.workShiftSettings.call(workShifts);
  }

  bool checkSE({required int dateInt, required List<int> keyDate}) {
    keyDate.sort();
    return keyDate.first < dateInt && keyDate.last > dateInt;
  }

  bool check(
      {required int dateInt,
      required List<int> keyDate,
      required WorkShiftRegisteredDetail workShift}) {
    keyDate.sort();
    final checkId = workShifts.any((element) =>
        element.workShiftDetailId == workShift.workShiftDetailId &&
        element.workShiftSettingDetailId == workShift.workShiftSettingDetailId &&
        element.workDate.microsecond == workShift.workDate.microsecond);
    final checkSE = keyDate.first < dateInt && keyDate.last > dateInt;

    if (checkId || checkSE) {
      return true;
    }
    return false;
  }

  changeMinutes({required int value, required WorkShiftRegisteredDetail workShift}) {
    final index = workShifts.indexWhere((element) => element.startTime == workShift.startTime);
    setState(() {
      workShifts[index] = workShifts[index].copyWith(numberTime: value);
      widget.workShiftSettings.call(workShifts);
    });
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
