import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ListCheckboxDepartmentFilter extends StatefulWidget {
  const ListCheckboxDepartmentFilter({super.key, required this.onChange});

  final ValueChanged<List<Department>> onChange;

  @override
  State<ListCheckboxDepartmentFilter> createState() =>
      _ListCheckboxDepartmentFilterState();
}

class _ListCheckboxDepartmentFilterState
    extends State<ListCheckboxDepartmentFilter> {
  List<bool> listCheck = [];
  List<Department> listDepartment = [];

  @override
  void initState() {
    listCheck = List.filled(RequisitionTypeEnum.values.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<DepartmentBloc, DepartmentState>(
      builder: (context, state) {
        return Expanded(
          child: Column(
            children: [
              Text(
                appLocalizations.department,
                style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w400),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.departments
                      .mapIndexed(
                        (index, element) => Column(
                          children: [
                            CheckboxListTile(
                              value: listCheck[index],
                              onChanged: (value) => setValue(
                                  index: index,
                                  value: value,
                                  department: element),
                              subtitle: Text(
                                element.name,
                                style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3_5,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Divider(
                              height: SpacingUnit.x0_25,
                              color: colors.outline.withValues(alpha: 0.2),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  setValue({
    required int index,
    bool? value,
    required Department department,
  }) {
    setState(() {
      listCheck[index] = value ?? false;
      if (value == true) {
        listDepartment.add(department);
        widget.onChange.call(listDepartment);
      } else {
        listDepartment.remove(department);
        widget.onChange.call(listDepartment);
      }
    });
  }
}
