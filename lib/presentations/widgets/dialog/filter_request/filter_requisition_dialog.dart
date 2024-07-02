import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition/button_request.dart';
import 'package:base_app/presentations/pages/activate/requisition/warp_in_dialog.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_timm_ymd.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_department.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_type_flow.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FilterRequisitionDialog extends StatefulWidget {
  const FilterRequisitionDialog({super.key, required this.sendData, this.filter});

  final ValueChanged<FilterDialogModel> sendData;
  final FilterDialogModel? filter;

  @override
  State<FilterRequisitionDialog> createState() => _FilterRequisitionDialogState();
}

class _FilterRequisitionDialogState extends State<FilterRequisitionDialog> {
  String errorTime = '', nameDepartment = '';
  Department? department;
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  RequisitionTypeEnum? type;
  List<StatusRequestEnum> statuses = [];

  @override
  void initState() {
    if (widget.filter != null) {
      startTime = widget.filter!.startTime ?? DateTime.now();
      endTime = widget.filter!.endTime ?? DateTime.now();
      type = widget.filter!.type;
      nameDepartment = widget.filter!.department?.name ?? "";
      department =  widget.filter!.department;
      statuses = widget.filter!.statuses ?? [];
    }
    super.initState();
  }

  void setType({RequisitionTypeEnum? value}) {
    setState(() {
      type = value ?? RequisitionTypeEnum.bussiness;
    });

  }
  saveDrag({List<StatusRequestEnum>? value}) {
    setState(() {
      statuses = value ?? [];
    });
  }

  void setStartTime({required DateTime value}) {
    startTime = value;
  }

  void setEndTime({required DateTime value}) {
    endTime = value;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return SizedBox(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(appLocalizations.filter,
                  textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4)),
            ),
            Divider(
              color: colors.text,
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(SpacingUnit.x2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemAdd(
                    callback: () => _showBottomSheet(context),
                    title: appLocalizations.type,
                  ),
                  Text(
                    type?.configTypeName ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: SpacingUnit.x4),
                  ),
                  ItemAdd(
                    callback: () => _setDepartment(context),
                    title: appLocalizations.department,
                  ),
                  Text(
                    nameDepartment,
                    style: const TextStyle(
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                  ItemCreateTimeYMD(
                    check: true,
                    title: appLocalizations.startTime,
                    dateOfBirth: startTime,
                    onChangeDateOfBirth: (value) => setStartTime(value: value),
                  ),
                  ItemCreateTimeYMD(
                    check: true,
                    title: appLocalizations.endTime,
                    dateOfBirth: endTime,
                    onChangeDateOfBirth: (value) => setEndTime(value: value),
                  ),
                  WarpInDialog(
                    statuses: statuses,
                    onChange: (value) => saveDrag(value: value),
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
      ),
    );
  }

  _setDepartment(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetDepartmentWidget(
          onChange: (value) => setDepartment(value: value),
        );
      },
    );
  }

  setReject(BuildContext context) {
    widget.sendData.call(const FilterDialogModel());
    popDialog(context);
  }


  setApply(BuildContext context) {
    widget.sendData.call(
      FilterDialogModel(
        type: type,
        endTime: endTime,
        startTime: startTime,
        statuses: statuses,
        department: department,
        departmentName: nameDepartment,
      ),
    );
    popDialog(context);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetTypeFlowWidget(
          onChange: (value) => setType(value: value),
        );
      },
    );
  }

  setDepartment({Map? value}) {
    setState(() {
      nameDepartment = value?['name'].toString() ?? "";
      department = value?['department'] ?? const Department(id: "", createdUserId: "");
    });
  }
}
