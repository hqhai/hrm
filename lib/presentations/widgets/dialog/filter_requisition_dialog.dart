import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class FilterRequisitionDialog extends StatefulWidget {
  const FilterRequisitionDialog({super.key, required this.sendData});

  final ValueChanged<FilterDialogModel> sendData;

  @override
  State<FilterRequisitionDialog> createState() => _FilterRequisitionDialogState();
}

class _FilterRequisitionDialogState extends State<FilterRequisitionDialog> {
  String startTime = DateFormat('yyyy-MM-dd').format(DateTime.now()),
      endTime = DateFormat('yyyy-MM-dd').format(DateTime.now());
  RequisitionTypeEnum type = RequisitionTypeEnum.explanation;
  List<StatusRequestEnum> statuses = [];

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

  void setStartTime({required String value}) {
    startTime = value;
  }

  void setEndTime({required String value}) {
    endTime = value;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return SizedBox(
      width: width,
      height: height * 0.6,
      child: SingleChildScrollView(
        child: Column(
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
                  Text(
                    appLocalizations.type,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: SpacingUnit.x3,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Center(
                    child: DropdownMenu<RequisitionTypeEnum>(
                      textStyle: const TextStyle(fontSize: SpacingUnit.x3),
                      initialSelection: RequisitionTypeEnum.explanation,
                      onSelected: (RequisitionTypeEnum? value) => setType(value: value),
                      dropdownMenuEntries: RequisitionTypeEnum.values
                          .map<DropdownMenuEntry<RequisitionTypeEnum>>((RequisitionTypeEnum value) {
                        return DropdownMenuEntry<RequisitionTypeEnum>(
                            value: value, label: value.configTypeName);
                      }).toList(),
                    ),
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
                  Text(
                    appLocalizations.status,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: SpacingUnit.x3, fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Wrap(
                    spacing: SpacingUnit.x4,
                    runSpacing: SpacingUnit.x3,
                    children: StatusRequestEnum.values
                        .map(
                          (eStatus) => GestureDetector(
                            onTap: () => saveDrag(eStatus: eStatus),
                            child: Container(
                              padding: const EdgeInsets.all(SpacingUnit.x1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(SpacingUnit.x1),
                                color: statuses.contains(eStatus)
                                    ? colors.error
                                    : CustomsColor.colorBackground,
                                border: Border.all(color: colors.text, width: SpacingUnit.x0_25),
                              ),
                              child: Text(eStatus.configRequestStatusName),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
            Row(
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
          ],
        ),
      ),
    );
  }

  setApply() {
    widget.sendData.call(
        FilterDialogModel(type: type, endTime: endTime, startTime: startTime, statuses: statuses));
    dI<RequisitionBloc>().add(
        GetRequisitionsByFilterEvent(requisitionTypeEnum: type, listStatusRequisition: statuses));
    popDialog(context);
  }
}
