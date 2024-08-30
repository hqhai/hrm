import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ShiftTimekeepingItem extends StatelessWidget {
  const ShiftTimekeepingItem({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(
              appLocalizations.shiftOfDay,
              style: const TextStyle(
                fontSize: SpacingUnit.x4_5,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: SpacingUnit.x1_5,
            ),
            Column(
              children: state.scheduleSchools.timeUnits
                  .map((e) => Padding(
                        padding: const EdgeInsets.only(top: 7),
                        child: Text(
                          '${strSeconds(e.startTime) ?? ""} - ${strSeconds(e.endTime) ?? ""}',
                          style: TextStyle(
                            color: colors.primary,
                            fontSize: SpacingUnit.x4,
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        );
      },
    );
  }
}
