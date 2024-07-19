import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemDayOfList extends StatelessWidget {
  const ItemDayOfList({super.key, required this.dateTime, this.workDayId});

  final DateTime dateTime;
  final String? workDayId;

  @override
  Widget build(BuildContext context) {
    //final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<WorkDayBloc, WorkDayState>(
      builder: (context, state) {
        final workDay = state.workDays[workDayId];
        return Column(
          children: [
            Container(
              width: width,
              color: colors.surfaceVariantLow,
              child: Padding(
                padding: const EdgeInsets.all(SpacingUnit.x3),
                child: Text(
                  formatYMD(dateTime.toString()),
                  style: TextStyle(
                      color: colors.text, fontSize: SpacingUnit.x3_5, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            workDayId != null
                ? Column(
                    children: workDay!.shifts
                        .map(
                          (e) => Padding(
                            padding: const EdgeInsets.all(SpacingUnit.x4),
                            child: ContainerBorder(
                              width: width,
                              child: Text(
                                '${formatYMD(e.startTime.toString())} - ${formatYMD(e.endTime.toString())}',
                                style: TextStyle(
                                  color: colors.text,
                                  fontSize: SpacingUnit.x3,
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  )
                : Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x7),
                    child: Text(
                      'Không có ca làm việc',
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x3_5,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
