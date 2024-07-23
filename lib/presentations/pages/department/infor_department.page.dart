import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final informationDepartmentPageRoute = GoRoute(
    name: Pages.informationDepartmentPage,
    path: Pages.informationDepartmentPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return InformationDepartmentPage(
        id: data['id'],
      );
    });

class InformationDepartmentPage extends StatefulWidget {
  const InformationDepartmentPage({super.key, required this.id});

  final String id;

  @override
  State<InformationDepartmentPage> createState() => _InformationDepartmentPageState();
}

class _InformationDepartmentPageState extends State<InformationDepartmentPage> {
  @override
  void initState() {
    dI<DepartmentBloc>().add(GetDepartmentByIdEvent(id: widget.id));
    super.initState();
  }

  String _parent(DepartmentState state) {
    return state.departments.where((e) => e.parentId == state.department.parentId).first.name ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final appLocalizations = AppLocalizations.of(context)!;
    return BasePage(
      appbar: AppBar(
        title: Text(appLocalizations.updateDepartment,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocBuilder<DepartmentBloc, DepartmentState>(
        builder: (context, state) => Container(
          margin: const EdgeInsets.all(SpacingUnit.x2),
          padding: const EdgeInsets.all(SpacingUnit.x2),
          height: height,
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
                const SizedBox(height: SpacingUnit.x4),
                Text(appLocalizations.name,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  state.department.name ?? "",
                  style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.phoneNumber,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  state.department.phoneNumber ?? "",
                  style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.email,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  state.department.email ?? "",
                  style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.address,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  state.department.address ?? "",
                  style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.description,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                Text(
                  state.department.description ?? '',
                  style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.parent,
                    style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                Text(
                  _parent(state),
                  style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text),
                ),
                const SizedBox(height: SpacingUnit.x4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
