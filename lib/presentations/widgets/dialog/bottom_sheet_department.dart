import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetDepartmentWidget extends StatefulWidget {
  const BottomSheetDepartmentWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<Map> onChange;

  @override
  State<BottomSheetDepartmentWidget> createState() => _BottomSheetDepartmentWidgetState();
}

class _BottomSheetDepartmentWidgetState extends State<BottomSheetDepartmentWidget> {
  String? searchStr;
  Department? department;
  List<Map> mapDepartment = [];

  @override
  void initState() {
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    super.initState();
  }

  setDepartment({Map? value}) {
    setState(() {
      department = value?['department'] ?? const Department(id: "", createdUserId: "");
    });
  }

  addDepartment(Department department) {
    for (var e in department.children) {
      setState(() {
        mapDepartment.add({
          'department': e,
          'name': "${department.name} - ${e.name}",
        });
      });
      if (e.children.isNotEmpty) {
        addDepartment(e);
      }
    }
  }

  listDepartment(List<Department> departments) {
    for (var element in departments) {
      if (element.children.isNotEmpty) {
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
            'name': element.name,
          });
        });
        listDepartment(state.departments);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocListener<DepartmentBloc, DepartmentState>(
        listener: (context, state) => _listener(context, state),
        child: Container(
          height: height * 0.6,
          color: colors.background,
          child: Center(
            child: SizedBox(
              height: height * 0.4,
              child: ListView.builder(
                itemCount: mapDepartment.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => setOnChange(
                    departmentMap: mapDepartment[index],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(SpacingUnit.x2),
                    margin: const EdgeInsets.all(SpacingUnit.x2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x2),
                      color: colors.background,
                      border: Border.all(
                        color: colors.text,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${index + 1}.    ',
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x3,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.8,
                          child: Text(
                            mapDepartment[index]['name'],
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  setOnChange({required Map departmentMap}) {
    widget.onChange.call(departmentMap);
    Navigator.of(context).pop();
  }
}
