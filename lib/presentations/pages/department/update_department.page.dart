import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

final updateDepartmentPageRoute = GoRoute(
    name: Pages.updateDepartmentPage,
    path: Pages.updateDepartmentPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return UpdateDepartmentPage(
        index: data['index'],
      );
    });

class UpdateDepartmentPage extends StatefulWidget {
  const UpdateDepartmentPage({super.key, required this.index});

  final int index;

  @override
  State<UpdateDepartmentPage> createState() => _UpdateDepartmentPageState();
}

class _UpdateDepartmentPageState extends State<UpdateDepartmentPage> {
  final TextEditingController nameController = TextEditingController(), codeController = TextEditingController(), emailController = TextEditingController(), phoneNumberController = TextEditingController(), addressController = TextEditingController(), descriptionController = TextEditingController();
  String name = '', code = '', email = '', address = '', phoneNumber = '', parent = '';
  List<String> listParents = const [];

  @override
  void initState() {
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    super.initState();
  }

  _listener(BuildContext context, DepartmentState state) {
    nameController.text = state.departments[widget.index].name;
    emailController.text = state.departments[widget.index].email;
    phoneNumberController.text = state.departments[widget.index].phoneNumber;
    addressController.text = state.departments[widget.index].address;
    descriptionController.text = state.departments[widget.index].description;
    parent = state.departments.where((e) => e.parentId == state.departments[widget.index].parentId).first.name;
    name = state.departments[widget.index].name;
    email = state.departments[widget.index].email;
    address = state.departments[widget.index].address;
    phoneNumber = state.departments[widget.index].phoneNumber;
    if (state.status == DepartmentStatus.updateDepartmentSuccess) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      successDialog(context);
      dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    } else if (state.status == DepartmentStatus.updateDepartmentInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == DepartmentStatus.updateDepartmentError) {
      Navigator.of(context).pop();
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final appLocalizations = AppLocalizations.of(context)!;
    return BasePage(
      appbar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(appLocalizations.updateDepartment, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocConsumer<DepartmentBloc, DepartmentState>(
        listener: (context, state) {
          _listener(context, state);
        },
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
                Text(appLocalizations.name, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.name,
                  controller: nameController,
                  onChange: (value) => setState(() => name = value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.code, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.code,
                  controller: codeController,
                  onChange: (value) => setState(() => code = value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.phoneNumber, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.phoneNumber,
                  controller: phoneNumberController,
                  onChange: (value) => setState(() => phoneNumber = value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.email, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.email,
                  controller: emailController,
                  onChange: (value) => setState(() => email = value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.address, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.address,
                  controller: addressController,
                  onChange: (value) => setState(() => address = value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.description, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInputArea(
                  placeHolder: appLocalizations.description,
                  controller: descriptionController,
                  minLines: 5,
                  maxLines: 5,
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.parent, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                DropdownMenu<String>(
                  width: width * 0.6,
                  initialSelection: _parentInit(state),
                  onSelected: (String? value) {
                    setState(() {
                      parent = value!;
                    });
                  },
                  dropdownMenuEntries: state.departments.map((e) => e.name).toList().map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
                const SizedBox(height: SpacingUnit.x4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo),
                  onPressed: () => _updateDialog(context, state),
                  child: Text(appLocalizations.update, style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _parentInit(DepartmentState state) {
    return state.departments.where((e) => e.parentId == state.departments[widget.index].parentId).first.name;
  }

  bool _checkTextField() {
    return name != '' && code != '' && email != '' && address != '' && phoneNumber != '';
  }

  String parentId(String parentName, DepartmentState state) {
    Department department = state.departments.where((element) => element.name.toString() == parentName.toString()).first;
    return department.id;
  }

  _updateDialog(BuildContext context, DepartmentState state) {
    //final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {}
  }
}
