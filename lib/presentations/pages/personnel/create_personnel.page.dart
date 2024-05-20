import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_bloc.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_event.dart';
import 'package:base_app/presentations/bloc/personnel/personnel_state.dart';
import 'package:base_app/presentations/bloc/position/position_bloc.dart';
import 'package:base_app/presentations/bloc/position/position_event.dart';
import 'package:base_app/presentations/bloc/position/position_state.dart';
import 'package:base_app/presentations/widgets/admin/department/item_dropdown_department.dart';
import 'package:base_app/presentations/widgets/admin/position/item_dropdown_position.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/custom/work_time.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

final createPersonnelPageRoute = GoRoute(
    name: Pages.createPersonnelPage,
    path: Pages.createPersonnelPage,
    builder: (context, GoRouterState state) => const CreatePersonnelWidget());

class CreatePersonnelWidget extends StatefulWidget {
  const CreatePersonnelWidget({super.key});

  @override
  State<CreatePersonnelWidget> createState() => _CreatePersonnelWidgetState();
}

class _CreatePersonnelWidgetState extends State<CreatePersonnelWidget> {
  final TextEditingController codeController = TextEditingController(),
      firstNameController = TextEditingController(),
      lastNameController = TextEditingController(),
      emailController = TextEditingController(),
      phoneNumberController = TextEditingController(),
      attendanceIdController = TextEditingController();
  String firstName = '',
      lastName = '',
      email = '',
      morningStartTime = formatHMS(DateTime.now().toString()),
      morningEndTime = formatHMS(DateTime.now().toString()),
      afternoonStartTime = formatHMS(DateTime.now().toString()),
      afternoonEndTime = formatHMS(DateTime.now().toString()),
      startDate = formatYMD(DateTime.now().toString());
  bool isWorkTime = false;
  List<String> departmentName = [""], positionName = [""];

  @override
  void initState() {
    //dI<PersonnelBloc>().add(const GetPersonnelsEvent());
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    dI<PositionBloc>().add(const GetPositionsEvent());
    super.initState();
  }

  _listenerPersonnel(BuildContext context, PersonnelState state) {
    if (state.status == PersonnelStatus.createPersonnelSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
      codeController.text = '';
      firstNameController.text = '';
      lastNameController.text = '';
      emailController.text = '';
      phoneNumberController.text = '';
      attendanceIdController.text = '';
      //dI<PersonnelBloc>().add(const GetPersonnelsEvent());
    } else if (state.status == PersonnelStatus.createPersonnelInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == PersonnelStatus.createPersonnelError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.sizeOf(context).height;
    return BasePage(
      appbar: AppBar(
        title: Text(appLocalizations.createPersonnel,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocConsumer<PersonnelBloc, PersonnelState>(
        listener: (context, state) => _listenerPersonnel(context, state),
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(SpacingUnit.x2),
          padding: const EdgeInsets.all(SpacingUnit.x2),
          height: height,
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
                const SizedBox(height: SpacingUnit.x4),
                Text(appLocalizations.code,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.code,
                  controller: codeController,
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.firstName,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.firstName,
                  controller: firstNameController,
                  onChange: (value) => setState(() => firstName = value),
                ),
                Text(appLocalizations.lastName,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.lastName,
                  controller: lastNameController,
                  onChange: (value) => setState(() => lastName = value),
                ),
                Text(appLocalizations.email,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.email,
                  controller: emailController,
                  onChange: (value) => setState(() => email = value),
                ),
                Text(appLocalizations.phoneNumber,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.phoneNumber,
                  controller: phoneNumberController,
                ),
                Text(appLocalizations.attendanceId,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.attendanceId,
                  controller: attendanceIdController,
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.department,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                SizedBox(
                  height: SpacingUnit.x20 * departmentName.length,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: departmentName.length,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ItemDropdownDepartment(
                          onChange: (value) => setState(() {
                            departmentName[index] = value;
                          }),
                        ),
                        IconButton(
                          onPressed: () => _removeListDepartmentName(index),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(CustomsColor.colorBackground),
                            overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                          ),
                          icon: const Icon(Icons.delete, color: Colors.red, size: SpacingUnit.x7_5),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _addListDepartmentName(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: SpacingUnit.x5),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.position,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                SizedBox(
                  height: SpacingUnit.x20 * positionName.length,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: positionName.length,
                    itemBuilder: (context, index) => Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ItemDropdownPosition(
                          onChange: (value) => setState(() {
                            positionName[index] = value;
                          }),
                        ),
                        IconButton(
                          onPressed: () => _removeListPositionName(index),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(CustomsColor.colorBackground),
                            overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                          ),
                          icon: const Icon(Icons.delete, color: Colors.red, size: SpacingUnit.x7_5),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => _addListPositionName(),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    overlayColor: MaterialStateProperty.all<Color>(Colors.indigo),
                  ),
                  icon: const Icon(Icons.add, color: Colors.white, size: SpacingUnit.x5),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.startDate,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                DatePicker(restorationId: 'StartDate', onChange: (value) => startDate = value),
                const SizedBox(height: SpacingUnit.x2),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                  onPressed: () => setState(() {
                    isWorkTime = !isWorkTime;
                  }),
                  child: Text(
                      !isWorkTime ? appLocalizations.addWorkTime : appLocalizations.removeWorkTime,
                      style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
                ),
                if (isWorkTime)
                  WorkTime(
                    onChangeMorningStartTime: (value) => morningStartTime = value,
                    onChangeMorningEndTime: (value) => morningEndTime = value,
                    onChangeAfternoonStartTime: (value) => afternoonStartTime = value,
                    onChangeAfternoonEndTime: (value) => afternoonEndTime = value,
                  ),
                const SizedBox(height: SpacingUnit.x4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo),
                  onPressed: () =>
                      _createDialog(context, dI<PositionBloc>().state, dI<DepartmentBloc>().state),
                  child: Text(appLocalizations.create,
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkTextField() {
    return firstName != '' && lastName != '' && email != '';
  }

  List<String> _departmentId(DepartmentState state) {
    List<String> listDepartment = departmentName
        .map((name) => state.departments
            .firstWhere((element) => element.name.toString() == name.toString())
            .id)
        .toList();
    return listDepartment;
  }

  List<String> _positionId(PositionState state) {
    List<String> listPosition = positionName
        .map((name) =>
            state.positions.firstWhere((element) => element.name.toString() == name.toString()).id)
        .toList();
    return listPosition;
  }

  int _timeToSeconds(String time) {
    DateFormat format = DateFormat('HH:mm:ss');
    DateTime t1 = format.parse(time);
    DateTime t2 = format.parse("00:00:00");
    return t1.difference(t2).inSeconds;
  }

  _createDialog(BuildContext context, PositionState stateP, DepartmentState stateD) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {
      createDialog(
        context,
        appLocalizations.doYouWantToCreatePersonnel,
        () => !isWorkTime
            ? dI<PersonnelBloc>().add(
                CreatePersonnelEvent(
                  code: codeController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text == '' ? null : phoneNumberController.text,
                  attendanceId:
                      attendanceIdController.text == '' ? null : attendanceIdController.text,
                  startDate: startDate,
                  departmentId: _departmentId(stateD),
                  positionId: _positionId(stateP),
                ),
              )
            : dI<PersonnelBloc>().add(
                CreatePersonnelEvent(
                  code: codeController.text,
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  email: emailController.text,
                  phoneNumber: phoneNumberController.text == '' ? null : phoneNumberController.text,
                  attendanceId:
                      attendanceIdController.text == '' ? null : attendanceIdController.text,
                  startDate: startDate,
                  departmentId: _departmentId(stateD),
                  positionId: _positionId(stateP),
                  morningStartTime: _timeToSeconds(morningStartTime),
                  morningEndTime: _timeToSeconds(morningEndTime),
                  afternoonEndTime: _timeToSeconds(afternoonEndTime),
                  afternoonStartTime: _timeToSeconds(afternoonStartTime),
                ),
              ),
      );
    }
  }

  void _addListDepartmentName() {
    setState(() {
      departmentName.add("");
    });
  }

  void _addListPositionName() {
    setState(() {
      positionName.add("");
    });
  }

  _removeListPositionName(int index) {
    setState(() {
      positionName.removeAt(index);
    });
  }

  _removeListDepartmentName(int index) {
    setState(() {
      departmentName.removeAt(index);
    });
  }
}
