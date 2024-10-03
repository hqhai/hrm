import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/search_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BottomSheetDepartmentWidget extends StatefulWidget {
  const BottomSheetDepartmentWidget({
    super.key,
    required this.onChange,
    this.department,
  });

  final ValueChanged<Department> onChange;
  final Department? department;

  @override
  State<BottomSheetDepartmentWidget> createState() => _BottomSheetDepartmentWidgetState();
}

class _BottomSheetDepartmentWidgetState extends State<BottomSheetDepartmentWidget> {
  late ScrollController controller;
  String searchStr = '';
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  bool loadMore = true;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocConsumer<DepartmentBloc, DepartmentState>(
      listenWhen: (previous, current) => previous.departments != current.departments,
      listener: (context, state) => _listener(state),
      builder: (context, state) => Center(
        child: Padding(
          padding: const EdgeInsets.all(SpacingUnit.x4),
          child: Column(
            children: [
              Text(
                appLocalizations.department,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x5,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(SpacingUnit.x2),
                child: SearchInput(onChange: (value) => _onChangeSearch(value)),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: state.departments.length,
                  itemBuilder: (context, index) {
                    final department = state.departments[index];
                    return GestureDetector(
                      onTap: () => setOnChange(
                        department: department,
                        context: context,
                      ),
                      child: ContainerBorder(
                        borderColors: widget.department?.id == department.id
                            ? colors.orange.withOpacity(0.3)
                            : colors.background,
                        backgroundColors: widget.department?.id == department.id
                            ? colors.orange.withOpacity(0.3)
                            : colors.background,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${index + 1}.',
                              style: TextStyle(
                                  color: colors.text,
                                  fontSize: SpacingUnit.x5,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              width: SpacingUnit.x2,
                            ),
                            Expanded(
                              child: Text(
                                department.name ?? "",
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: colors.text,
                                  fontSize: SpacingUnit.x4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool check({required Department d}) {
    if (d.id == widget.department?.id) {
      return true;
    }
    return false;
  }

  setOnChange({required Department department, required BuildContext context}) {
    widget.onChange.call(department);
    dI<AppNavigation>().pop(context);
  }

  _scrollListener() async {
    if (lengthList < totalItems && loadMore && controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
        loadMore = false;
      });
      final Completer completer = Completer<bool>();
      dI<DepartmentBloc>().add(
        GetListDepartmentEvent(page: pageIndex, completer: completer, key: searchStr),
      );
      final check = await completer.future;
      if (check) {
        setState(() {
          loadMore = true;
        });
      }
    }
  }

  _listener(DepartmentState state) {
    setState(() {
      totalItems = state.totalItems;
      lengthList = state.departments.length;
    });
  }

  _onChangeSearch(String value) async {
    setState(() {
      searchStr = value;
      pageIndex++;
    });
    final Completer completer = Completer<bool>();
    dI<DepartmentBloc>().add(
      GetListDepartmentEvent(page: 1, completer: completer, key: searchStr),
    );
    final check = await completer.future;
    if (check) {
      setState(() {
        loadMore = true;
      });
    }
  }
}
