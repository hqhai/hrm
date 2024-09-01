import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_school.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemTimeKeepingGPS extends StatelessWidget {
  const ItemTimeKeepingGPS({
    super.key,
    required this.scheduleSchoolId,
    this.checkSuccessful = true,
  });

  final String scheduleSchoolId;
  final bool checkSuccessful;

  ScheduleSchool _school(List<ScheduleSchool> listSchool) {
    return listSchool.firstWhere((element) => element.id == scheduleSchoolId);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        final school = _school(state.scheduleSchools.scheduleSchools);
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.nameSchool,
              value: school.school.name,
            ),
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.nameClass,
              value: school.className,
            ),
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.nameTeacher,
              value: school.teacherName,
            ),
            if (checkSuccessful) ...[
              ItemTitleValueNoBorder(
                size: SpacingUnit.x3_5,
                font: FontWeight.w600,
                title: appLocalizations.startTimeH,
                value: strSeconds(
                      school.startTime,
                    ) ??
                    "",
              ),
              ItemTitleValueNoBorder(
                size: SpacingUnit.x3_5,
                font: FontWeight.w600,
                title: appLocalizations.endTimeH,
                value: strSeconds(
                      school.endTime,
                    ) ??
                    "",
              ),
            ],
          ],
        );
      },
    );
  }
}
