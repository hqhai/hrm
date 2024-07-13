import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/home_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_state.dart';
import 'package:base_app/presentations/widgets/attendance/attendance/form_change_time.dart';
import 'package:base_app/presentations/widgets/attendance/attendance/item_work_sheet.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets/app_button.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String id = '';
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    dI<WorkSheetBloc>().add(GetWorkSheetEvent(time: currentDateTime));
    dI<UserBloc>().add(const GetUserInfo());
    id = dI<UserBloc>().state.user.id;
    dI<AttendanceBloc>().add(GetAttendanceNowEvent(
      id: id,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<WorkSheetBloc, WorkSheetState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(SpacingUnit.x0_5),
            margin: const EdgeInsets.all(SpacingUnit.x0_5),
            decoration: BoxDecoration(
              color: CustomsColor.colorBackground,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormChangeTime(
                  month: currentDateTime.month.toString(),
                  year: currentDateTime.year.toString(),
                  downMonth: () => downMonth(),
                  upMonth: () => upMonth(),
                ),
                Column(
                  children: titleHome()
                      .mapIndexed(
                        (index, element) =>
                        ItemWorkSheet(
                          title: element,
                          value: listWork(state.workSheet)[index],
                        ),
                  )
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButton(
                      title: appLocalizations.seeDetails, onSubmit: () => nextWorkSheet(context)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  List<String> listWork(WorkSheet workSheet){
    List<String> list = [...workSheet.toListString()];
    return list;
  }

  downMonth() {
    setState(() {
      if (currentDateTime.month == 1) {
        currentDateTime = DateTime(currentDateTime.year - 1, 12, 1);
      } else {
        currentDateTime = DateTime(currentDateTime.year, currentDateTime.month - 1, 1);
      }
    });
    dI<WorkSheetBloc>().add(GetWorkSheetEvent(time: currentDateTime));
  }

  upMonth() {
    setState(() {
      if (currentDateTime.month == 12) {
        currentDateTime = DateTime(currentDateTime.year + 1, 1, 1);
      } else {
        currentDateTime = DateTime(currentDateTime.year, currentDateTime.month + 1, 1);
      }
    });
    dI<WorkSheetBloc>().add(GetWorkSheetEvent(time: currentDateTime));
  }

  nextWorkSheet(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.layoutCalendarPage);
  }
}
