import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class FilterRequisitionApproveDialog extends StatefulWidget {
  const FilterRequisitionApproveDialog({super.key, required this.sendData});

  final ValueChanged<FilterDialogModel> sendData;

  @override
  State<FilterRequisitionApproveDialog> createState() => _FilterRequisitionApproveDialogState();
}

class _FilterRequisitionApproveDialogState extends State<FilterRequisitionApproveDialog> {
  String startTime = DateFormat('yyyy-MM-dd').format(DateTime.now()),
      endTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  RequisitionTypeEnum type = RequisitionTypeEnum.explanation;
  List<StatusRequestEnum> statuses = [];
  Department? department;
  List<Map> mapDepartment = [];

  @override
  void initState() {
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    super.initState();
  }

  void setType({RequisitionTypeEnum? value}) {
    type = value ?? RequisitionTypeEnum.bussiness;
  }

  void saveDrag({required StatusRequestEnum eStatus}) {
    if (!statuses.contains(eStatus)) {
      setState(() {
        statuses.add(eStatus);
      });
    } else {
      setState(() {
        statuses.remove(eStatus);
      });
    }
  }

  void setStartTime({required String value}) {
    startTime = value;
  }

  void setEndTime({required String value}) {
    endTime = value;
  }

  setDepartment({Map? value}) {
    setState(() {
      department = value?['department'] ?? const Department(id: "", createdUserId: "");
    });
  }

  addDepartment(Department department) {
    for (var e in department.childrens) {
      setState(() {
        mapDepartment.add({
          'department': e,
          'name': "${department.name ?? ""} - ${e.name ?? ""}",
        });
      });
      if (e.childrens.isNotEmpty) {
        addDepartment(e);
      }
    }
  }

  listDepartment(DepartmentState state) {
    for (var element in state.departments) {
      if (element.childrens.isNotEmpty) {
        addDepartment(element);
      }
    }
  }

  _listener(BuildContext context, DepartmentState state) {
    if (state.status == DepartmentStatus.getDepartmentSuccess) {
      for (var element in state.departments) {
        setState(() {
          mapDepartment.add({
            'department': element,
            'name': element.name ?? "",
          });
        });
        listDepartment(state);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocListener<DepartmentBloc, DepartmentState>(
      listener: (context, state) => _listener(context, state),
      child: SizedBox(
        width: width,
        height: height * 0.6,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: SpacingUnit.x4),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(appLocalizations.filter,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SpacingUnit.x6,
                        color: colors.text,
                        fontWeight: FontWeight.w800,
                      )),
                ),
              ),
              Divider(
                color: colors.text,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.type,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: SpacingUnit.x3,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    DropdownMenu<RequisitionTypeEnum>(
                      width: width * 0.7,
                      textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                      initialSelection: RequisitionTypeEnum.explanation,
                      onSelected: (RequisitionTypeEnum? value) => setType(value: value),
                      dropdownMenuEntries: RequisitionTypeEnum.values
                          .map<DropdownMenuEntry<RequisitionTypeEnum>>((RequisitionTypeEnum value) {
                        return DropdownMenuEntry<RequisitionTypeEnum>(
                          value: value,
                          label: value.configTypeName,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    Text(
                      appLocalizations.department,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: SpacingUnit.x3,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    DropdownMenu<Map>(
                      width: width * 0.7,
                      menuHeight: width * 0.7,
                      textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                      initialSelection: const {},
                      onSelected: (Map? value) => setDepartment(value: value),
                      dropdownMenuEntries: mapDepartment.map<DropdownMenuEntry<Map>>((Map value) {
                        return DropdownMenuEntry<Map>(
                          value: value,
                          label: value['name'],
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    Text(
                      appLocalizations.startTime,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    DatePicker(
                      onChange: (value) => setStartTime(value: value),
                      check: true,
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    Text(
                      appLocalizations.endTime,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                    DatePicker(
                      onChange: (value) => setEndTime(value: value),
                      check: true,
                    ),
                    const SizedBox(height: SpacingUnit.x3),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => setApply(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(appLocalizations.apply, style: TextStyle(color: colors.text)),
                  ),
                  ElevatedButton(
                    onPressed: () => popDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(appLocalizations.cancel, style: TextStyle(color: colors.text)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  setApply() {
    widget.sendData.call(
      FilterDialogModel(
        type: type,
        endTime: endTime,
        startTime: startTime,
        statuses: statuses,
        department: department,
      ),
    );
    popDialog(context);
  }
}
