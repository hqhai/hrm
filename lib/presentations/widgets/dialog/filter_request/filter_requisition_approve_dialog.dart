import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/button_request.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/item_time.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/list_checkbox_department_filter.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/list_checkbox_type_request_filter.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FilterRequisitionApproveDialog extends StatefulWidget {
  const FilterRequisitionApproveDialog({
    super.key,
    required this.sendData,
    this.filter,
  });

  final ValueChanged<FilterDialogModel> sendData;
  final FilterDialogModel? filter;

  @override
  State<FilterRequisitionApproveDialog> createState() => _FilterRequisitionApproveDialogState();
}

class _FilterRequisitionApproveDialogState extends State<FilterRequisitionApproveDialog> {
  String errorTime = '';
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  StatusRequestEnum status = StatusRequestEnum.process;
  List<RequisitionTypeEnum>? types;
  Department? departments;
  User? user;

  @override
  void initState() {
    if (widget.filter != null) {
      user = widget.filter!.user;
      startTime = widget.filter!.startTime ?? DateTime.now();
      endTime = widget.filter!.endTime ?? DateTime.now();
      types = widget.filter!.types;
      departments = widget.filter!.department;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.95,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          HeaderFilter(callback: () => close(context)),
          Divider(
            color: colors.outline.withOpacity(0.5),
            thickness: 1,
          ),
          Expanded(
            child: ListCheckboxTypeRequestFilter(
              onChange: (value) => _setListType(value),
            ),
          ),
          ListCheckboxDepartmentFilter(
            onChange: (value) => _setDepartment(value),
          ),
          Padding(
            padding: const EdgeInsets.all(SpacingUnit.x2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ItemTimeFilter(
                      title: appLocalizations.startTime,
                      dateOfBirth: startTime,
                      onChangeDateOfBirth: (value) => setStartTime(value: value),
                    ),
                    ItemTimeFilter(
                      title: appLocalizations.endTime,
                      dateOfBirth: endTime,
                      onChangeDateOfBirth: (value) => setEndTime(value: value),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ButtonRequest(
            title1: appLocalizations.apply,
            title2: appLocalizations.cancel,
            apply: () => setApply(context),
            reject: () => setReject(context),
          ),
        ],
      ),
    );
  }

  close(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setListType(List<RequisitionTypeEnum> value) {
    setState(() {
      types = value;
    });
  }

  void setStartTime({required DateTime value}) {
    setState(() {
      startTime = value;
    });
  }

  void setEndTime({required DateTime value}) {
    setState(() {
      endTime = value;
    });
  }

  _setDepartment(List<Department> value) {

  }

  setApply(BuildContext context) {
    widget.sendData.call(
      FilterDialogModel(
        types: types,
        endTime: endTime,
        startTime: startTime,
        department: departments,
        user: user,
      ),
    );
    popDialog(context);
  }

  setReject(BuildContext context) {
    widget.sendData.call(const FilterDialogModel());
    popDialog(context);
  }

  setPersonnel({required User value}) {
    setState(() {
      user = value;
    });
  }
}
