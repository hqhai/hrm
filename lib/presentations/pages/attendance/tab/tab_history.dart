import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:base_app/presentations/pages/attendance/tab/item_shift_on_tab.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class OTHistory extends StatelessWidget {
  const OTHistory({super.key, required this.dateTime});

  final DateTime dateTime;

  UserWorkingHistoryModel userWorkingHistoryModelByDate(
      List<UserWorkingHistoryModel> list) {
    return list.firstWhere(
        (element) => element.date?.isAtSameMomentAs(dateTime) ?? false);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<WorkSheetBloc, WorkSheetState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(
              right: SpacingUnit.x7, left: SpacingUnit.x7, top: SpacingUnit.x4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.keys.isNotEmpty
                    ? appLocalizations.gPSAndFingerprint
                    : appLocalizations.noTimekeeping,
                style: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w600,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              // const SizedBox(
              //   height: SpacingUnit.x6,
              // ),
              if (state.keys.isNotEmpty)
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: SpacingUnit.x6),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: state.keys.mapIndexed((index, element) {
                          final attendance = state.attendances[element];
                          return ItemShiftOnTab(
                            title: appLocalizations.checkIn,
                            value:
                                formatHM(attendance?.timeChecking.toString()),
                            checkInMethodEnum: attendance?.checkInMethod ?? CheckInMethodEnum.gPS,
                            last: element != state.keys.last,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
