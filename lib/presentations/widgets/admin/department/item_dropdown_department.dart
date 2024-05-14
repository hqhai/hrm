import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemDropdownDepartment extends StatefulWidget {
  const ItemDropdownDepartment({super.key, required this.onChange});

  final ValueChanged<String> onChange;

  @override
  State<ItemDropdownDepartment> createState() => _ItemDropdownDepartmentState();
}

class _ItemDropdownDepartmentState extends State<ItemDropdownDepartment> {

  String departmentName = '';

  _listenerDepartment(BuildContext context, DepartmentState state) {
    departmentName = state.departments.map((e) => e.name).toList().first;
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return BlocConsumer<DepartmentBloc, DepartmentState>(
      listener: (context, state) => _listenerDepartment(context, state),
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(SpacingUnit.x2),
          child: DropdownMenu<String>(
            width: width * 0.6,
            initialSelection: departmentName,
            onSelected: (String? value) => _select(value),
            dropdownMenuEntries: state.departments
                .map((e) => e.name)
                .toList()
                .map<DropdownMenuEntry<String>>((String value) {
              return DropdownMenuEntry<String>(value: value, label: value);
            }).toList(),
          ),
        );
      },
    );
  }

  _select(String? value){
    setState(() {
      departmentName = value!;
      widget.onChange.call(departmentName);
    });
  }
}
