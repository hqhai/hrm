import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_over_time_history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTTab extends StatelessWidget {
  const OTTab({super.key, required this.dateTime});

  final DateTime dateTime;

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel =
            userWorkingHistoryModelByDate(state.attendance.userWorkingHistories);
        return Padding(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          child: Column(
              children: userWorkingHistoryModel.userOverTimeHistories
                  .map(
                    (e) => ItemOverTimeHistory(
                      userOverTimeHistory: e,
                    ),
                  )
                  .toList()),
        );
      },
    );
  }
}
