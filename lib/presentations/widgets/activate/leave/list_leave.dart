import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/pages/activate/leave/item_leave.dart';
import 'package:flutter/material.dart';

class ListLeaveWidget extends StatefulWidget {
  const ListLeaveWidget({
    super.key,
  });

  @override
  State<ListLeaveWidget> createState() => _ListLeaveWidgetState();
}

class _ListLeaveWidgetState extends State<ListLeaveWidget> {
  @override
  void initState() {
    dI<WorkAndSalaryBloc>().add(const GetTotalLeaveDayEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SpacingUnit.x4,
        ),
        child: Column(
          children: EnumLeaveHistoryType.values
              .where((element) =>
                  element != EnumLeaveHistoryType.unknown &&
                  element != EnumLeaveHistoryType.funeralLeave &&
                  element != EnumLeaveHistoryType.marriageLeave)
              .map((e) => ItemLeave(type: e))
              .toList(),
        ),
      ),
    );
  }
}
