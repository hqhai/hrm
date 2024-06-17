import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_bloc.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_event.dart';
import 'package:base_app/presentations/bloc/checkin_setting/check_in_setting_state.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/admin/department/item_dropdown_department.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/work_time.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final createCheckInSettingPageRoute = GoRoute(
    name: Pages.createCheckInSettingPage,
    path: Pages.createCheckInSettingPage,
    builder: (context, GoRouterState state) => const CreateCheckInSettingWidget());

class CreateCheckInSettingWidget extends StatefulWidget {
  const CreateCheckInSettingWidget({super.key});

  @override
  State<CreateCheckInSettingWidget> createState() => _CreateCheckInSettingWidgetState();
}

class _CreateCheckInSettingWidgetState extends State<CreateCheckInSettingWidget> {
  String morningStartTime = formatHMS(DateTime.now().toString()),
      morningEndTime = formatHMS(DateTime.now().toString()),
      afternoonStartTime = formatHMS(DateTime.now().toString()),
      afternoonEndTime = formatHMS(DateTime.now().toString()),
      department = '';

  List<String> listParents = const [];

  @override
  void initState() {
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    super.initState();
  }

  _listener(BuildContext context, CheckInSettingState state) {
    if (state.status == CheckInSettingStatus.createCheckInSettingSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
      //dI<CheckInSettingBloc>().add(const GetCheckInSettingsEvent());
    } else if (state.status == CheckInSettingStatus.createCheckInSettingInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == CheckInSettingStatus.createCheckInSettingError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BasePage(
      appbar: AppBar(
        title: Text(appLocalizations.createCheckInSetting,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocListener<CheckInSettingBloc, CheckInSettingState>(
        listener: (context, state) {
          _listener(context, state);
        },
        child: Container(
          margin: const EdgeInsets.all(SpacingUnit.x2),
          padding: const EdgeInsets.all(SpacingUnit.x2),
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x4),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations.department,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                ItemDropdownDepartment(
                  onChange: (value) => department = value,
                ),
                WorkTime(
                  onChangeMorningStartTime: (value) => morningStartTime = value,
                  onChangeMorningEndTime: (value) => morningEndTime = value,
                  onChangeAfternoonStartTime: (value) => afternoonStartTime = value,
                  onChangeAfternoonEndTime: (value) => afternoonEndTime = value,
                ),
                const SizedBox(height: SpacingUnit.x4),
                BlocBuilder<DepartmentBloc, DepartmentState>(
                  builder: (context, state) {
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      onPressed: () => _createDialog(context, state),
                      child: Text(appLocalizations.create,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _departmentId(String departmentName, DepartmentState state) {
    Department department = state.departments
        .where((element) => element.name.toString() == departmentName.toString())
        .first;
    return department.id;
  }

  int _timeToSeconds(String time) {
    DateFormat format = DateFormat('HH:mm:ss');
    DateTime t1 = format.parse(time);
    DateTime t2 = format.parse("00:00:00");
    return t1.difference(t2).inSeconds;
  }

  _createDialog(BuildContext context, DepartmentState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    createDialog(
      context,
      appLocalizations.doYouWantToCreateCheckInSetting,
      () => dI<CheckInSettingBloc>().add(CreateCheckInSettingEvent(
          departmentId: _departmentId(department, state),
          afternoonStartTime: _timeToSeconds(afternoonStartTime),
          afternoonEndTime: _timeToSeconds(afternoonEndTime),
          morningStartTime: _timeToSeconds(morningStartTime),
          morningEndTime: _timeToSeconds(morningEndTime))),
    );
  }
}
