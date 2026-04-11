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

  UserWorkingHistoryModel? userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    for (final element in list) {
      final d = element.date;
      if (d == null) continue;
      if (d.year == dateTime.year && d.month == dateTime.month && d.day == dateTime.day) {
        return element;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final userWorkingHistoryModel =
            userWorkingHistoryModelByDate(state.attendance.userWorkingHistories);
        final histories = userWorkingHistoryModel?.userOverTimeHistories ?? [];
        return Padding(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          child: Column(
              children: histories
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
