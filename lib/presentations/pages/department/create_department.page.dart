import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/department/department_bloc.dart';
import 'package:base_app/presentations/bloc/department/department_event.dart';
import 'package:base_app/presentations/bloc/department/department_state.dart';
import 'package:base_app/presentations/widgets/admin/department/item_dropdown_department.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

final createDepartmentPageRoute = GoRoute(name: Pages.createDepartmentPage, path: Pages.createDepartmentPage, builder: (context, GoRouterState state) => const CreateDepartmentWidget());

class CreateDepartmentWidget extends StatefulWidget {
  const CreateDepartmentWidget({super.key});

  @override
  State<CreateDepartmentWidget> createState() => _CreateDepartmentWidgetState();
}

class _CreateDepartmentWidgetState extends State<CreateDepartmentWidget> {
  final TextEditingController nameController = TextEditingController(), codeController = TextEditingController(), emailController = TextEditingController(), phoneNumberController = TextEditingController(), addressController = TextEditingController(), descriptionController = TextEditingController();
  String name = '', code = '', email = '', address = '', phoneNumber = '', parent = '';
  List<String> listParents = const [];

  @override
  void initState() {
    dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    codeController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  _listener(BuildContext context, DepartmentState state) {
    if (state.status == DepartmentStatus.getDepartmentSuccess) {
      parent = state.departments.map((e) => e.name).toList().first;
    }
    if (state.status == DepartmentStatus.createDepartmentSuccess) {
      Navigator.of(context).pop();
      successDialog(context);
      codeController.text = '';
      emailController.text = '';
      phoneNumberController.text = '';
      addressController.text = '';
      descriptionController.text = '';
      dI<DepartmentBloc>().add(const GetDepartmentsEvent());
    } else if (state.status == DepartmentStatus.createDepartmentInit) {
      Navigator.of(context).pop();
      progressIndicatorDialog(context);
    } else if (state.status == DepartmentStatus.createDepartmentError) {
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
        iconTheme: IconThemeData(color: colors.text),
        title: Text(appLocalizations.createDepartment, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
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
                  onChange: (value) => setName(value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.code, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.code,
                  controller: codeController,
                  onChange: (value) => setCode(value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.phoneNumber, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.phoneNumber,
                  controller: phoneNumberController,
                  onChange: (value) => setPhoneNumber(value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.email, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.email,
                  controller: emailController,
                  onChange: (value) => setEmail(value),
                ),
                const SizedBox(height: SpacingUnit.x2),
                Text(appLocalizations.address, style: TextStyle(fontSize: SpacingUnit.x5, color: colors.orange)),
                const SizedBox(height: SpacingUnit.x2),
                AppInput(
                  placeHolder: appLocalizations.address,
                  controller: addressController,
                  onChange: (value) => setAddress(value),
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
                ItemDropdownDepartment(
                  onChange: (value) => setParent(value),
                ),
                const SizedBox(height: SpacingUnit.x4),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: _checkTextField() ? Colors.blue : Colors.indigo),
                  onPressed: () => _createDialog(context, state),
                  child: Text(appLocalizations.create, style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkTextField() {
    return name != '' && code != '' && email != '' && address != '' && phoneNumber != '';
  }

  String parentId(String parentName, DepartmentState state) {
    Department department = state.departments.where((element) => element.name.toString() == parentName.toString()).first;
    return department.id;
  }

  _createDialog(BuildContext context, DepartmentState state) {
    //final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {}
  }

  setName(String value) {
    setState(() => name = value);
  }

  setCode(String value) {
    setState(() => code = value);
  }

  setPhoneNumber(String value) {
    setState(() => phoneNumber = value);
  }

  setEmail(String value) {
    setState(() => email = value);
  }

  setAddress(String value) {
    setState(() => address = value);
  }

  setParent(String value) {
    setState(() {
      parent = value;
    });
  }
}
