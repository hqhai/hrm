import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/department.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_department.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FilterRequisitionApproveDialog extends StatefulWidget {
  const FilterRequisitionApproveDialog({
    super.key,
    required this.sendData,
  });

  final ValueChanged<FilterDialogModel> sendData;

  @override
  State<FilterRequisitionApproveDialog> createState() => _FilterRequisitionApproveDialogState();
}

class _FilterRequisitionApproveDialogState extends State<FilterRequisitionApproveDialog> {
  String nameDepartment = '';
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  RequisitionTypeEnum type = RequisitionTypeEnum.explanation;
  List<StatusRequestEnum> statuses = [];
  Department? department;

  @override
  void initState() {
    super.initState();
  }

  void setType({RequisitionTypeEnum? value}) {
    type = value ?? RequisitionTypeEnum.bussiness;
  }

  void saveDrag({required StatusRequestEnum eStatus}) {
    if (!statuses.contains(eStatus)) {
      setState(() {
        statuses.add(eStatus);
      });
    } else {
      setState(() {
        statuses.remove(eStatus);
      });
    }
  }

  void setStartTime({required DateTime value}) {
    startTime = value;
  }

  void setEndTime({required DateTime value}) {
    endTime = value;
  }

  setDepartment({Map? value}) {
    setState(() {
      nameDepartment = value?['name'].toString() ?? "";
      department = value?['department'] ?? const Department(id: "", createdUserId: "");
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x4),
            child: Align(
              alignment: Alignment.center,
              child: Text(appLocalizations.filter,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SpacingUnit.x6,
                    color: colors.text,
                    fontWeight: FontWeight.w800,
                  )),
            ),
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
                Text(
                  appLocalizations.type,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: SpacingUnit.x3,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: SpacingUnit.x3),
                DropdownMenu<RequisitionTypeEnum>(
                  width: width * 0.7,
                  textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                  initialSelection: RequisitionTypeEnum.explanation,
                  onSelected: (RequisitionTypeEnum? value) => setType(value: value),
                  dropdownMenuEntries: RequisitionTypeEnum.values
                      .map<DropdownMenuEntry<RequisitionTypeEnum>>((RequisitionTypeEnum value) {
                    return DropdownMenuEntry<RequisitionTypeEnum>(
                      value: value,
                      label: value.configTypeName,
                    );
                  }).toList(),
                ),
                const SizedBox(height: SpacingUnit.x3),
                Row(
                  children: [
                    Text(
                      appLocalizations.department,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: SpacingUnit.x3,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _setDepartment(context),
                      child: Icon(
                        Icons.add,
                        size: SpacingUnit.x8,
                        color: colors.success,
                      ),
                    )
                  ],
                ),
                Text(
                  nameDepartment,
                  style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: SpacingUnit.x3),
                Text(
                  appLocalizations.startTime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: SpacingUnit.x3),
                DatePicker(
                  onChange: (value) => setStartTime(value: value),
                  check: true,
                ),
                const SizedBox(height: SpacingUnit.x3),
                Text(
                  appLocalizations.endTime,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: SpacingUnit.x3),
                DatePicker(
                  onChange: (value) => setEndTime(value: value),
                  check: true,
                ),
                const SizedBox(height: SpacingUnit.x3),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingUnit.x3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setApply(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(appLocalizations.apply, style: TextStyle(color: colors.text)),
                ),
                ElevatedButton(
                  onPressed: () => popDialog(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Text(appLocalizations.cancel, style: TextStyle(color: colors.text)),
                ),
              ],
            ),
          ),
        ],
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

  setApply() {
    widget.sendData.call(
      FilterDialogModel(
        type: type,
        endTime: endTime,
        startTime: startTime,
        statuses: statuses,
        department: department,
      ),
    );
    popDialog(context);
  }
}
