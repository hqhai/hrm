import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/admin/department/item_department.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class DepartmentWidget extends StatefulWidget {
  const DepartmentWidget({super.key});

  @override
  State<DepartmentWidget> createState() => _DepartmentWidgetState();
}

class _DepartmentWidgetState extends State<DepartmentWidget> {
  @override
  void initState() {
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    super.initState();
  }

  _listener(DepartmentState state) {
    if (state.status == DepartmentStatus.updateDepartmentSuccess ||
        state.status == DepartmentStatus.deleteDepartmentSuccess) {
      dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      body: BlocConsumer<DepartmentBloc, DepartmentState>(
        listener: (context, state) {
          _listener(state);
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(SpacingUnit.x2),
            padding: const EdgeInsets.all(SpacingUnit.x2),
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: const BorderRadius.all(
                Radius.circular(SpacingUnit.x4),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: state.departments.length * SpacingUnit.x35,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.departments.length,
                        itemBuilder: (context, index) {
                          return ItemDepartment(
                            index: index,
                          );
                        }),
                  ),
                  ElevatedButton(
                    onPressed: () => _nextCreateDepartmentPage(context),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                        appLocalizations.create,
                      style: TextStyle(fontSize: SpacingUnit.x4, color: colors.text),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _nextCreateDepartmentPage(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createDepartmentPage);
  }
}
