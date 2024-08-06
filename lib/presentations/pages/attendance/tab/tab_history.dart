import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/item_shift_on_tab.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OTHistory extends StatelessWidget {
  const OTHistory({super.key, required this.dateTime});

  final DateTime dateTime;

  UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
    return list.firstWhere((element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<WorkSheetBloc, WorkSheetState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state.keys.isNotEmpty)
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: state.keys.mapIndexed((index, element) {
                  final attendance = state.attendances[element];
                  return ItemShiftOnTab(
                    title: appLocalizations.checkIn,
                    value: formatHM(attendance?.timeChecking.toString()),
                    last: element != state.keys.last,
                  );
                }).toList(),
              ),
          ],
        );
      },
    );
  }
}
