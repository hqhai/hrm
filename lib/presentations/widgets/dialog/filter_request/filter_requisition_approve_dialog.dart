import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/user.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/button_request.dart';
import 'package:base_app/presentations/widgets/custom/period_time_picker.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_department.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_personnel.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
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
  DateTime? startTime, endTime;

  StatusRequestEnum status = StatusRequestEnum.process;
  List<RequisitionTypeEnum>? types;
  Department? departments;
  User? user;

  @override
  void initState() {
    if (widget.filter != null) {
      user = widget.filter!.user;
      startTime = widget.filter!.startTime;
      endTime = widget.filter!.endTime;
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListCheckboxTypeRequestFilter(
                    onChange: (value) => _setListType(value),
                  ),
                  SizedBox(
                    height: height * 0.6,
                    child: BottomSheetDepartmentWidget(
                      department: departments,
                      onChange: (value) => _setDepartment(value),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.6,
                    child: BottomSheetPersonnelWidget(
                      user: user,
                      onChange: (value) => _setPersonnel(value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(SpacingUnit.x2),
            child: PeriodTimePicker(
              title: appLocalizations.timeFrame,
              setStarTime: (value) => setStartTime(value: value),
              setEndTime: (value) => setEndTime(value: value),
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

  void setStartTime({DateTime? value}) {
    setState(() {
      startTime = value;
    });
  }

  void setEndTime({DateTime? value}) {
    setState(() {
      endTime = value;
    });
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

  _setDepartment(Map value) {
    setState(() {
      departments = value['department'];
    });
  }

  _setPersonnel(User value) {
    setState(() {
      user = value;
    });
  }
}
