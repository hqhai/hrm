import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListSchoolWidget extends StatelessWidget {
  const ListSchoolWidget({super.key, this.scheduleSchoolId = '', required this.onChange});

  final String scheduleSchoolId;
  final ValueChanged<String> onChange;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Column(
          children: state.scheduleSchools.scheduleSchools
              .map(
                (e) => GestureDetector(
                  onTap: () => onChange.call(e.id),
                  child: ContainerBorder(
                    backgroundColors: colors.background,
                    borderColors: e.id == scheduleSchoolId ? colors.navy : colors.background,
                    child: ItemTimeKeepingGPS(scheduleSchoolId: e.id),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
