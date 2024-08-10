import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemTimeKeepingGPS extends StatefulWidget {
  const ItemTimeKeepingGPS({
    super.key,
  });

  @override
  State<ItemTimeKeepingGPS> createState() => _ItemTimeKeepingGPSState();
}

class _ItemTimeKeepingGPSState extends State<ItemTimeKeepingGPS> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.nameSchool,
              value: state.scheduleSchool.school?.name ?? "",
            ),
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.nameClass,
              value: state.scheduleSchool.className,
            ),
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.start,
              value: strSeconds(
                    state.scheduleSchool.startTime,
                  ) ??
                  "",
            ),
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.end,
              value: strSeconds(
                    state.scheduleSchool.endTime,
                  ) ??
                  "",
            ),
            ItemTitleValueNoBorder(
              size: SpacingUnit.x3_5,
              font: FontWeight.w600,
              title: appLocalizations.nameTeacher,
              value: state.scheduleSchool.teacherName,
            ),
          ],
        );
      },
    );
  }
}
