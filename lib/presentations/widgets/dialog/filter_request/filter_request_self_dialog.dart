import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_flow.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class FilterRequestSelfDialog extends StatefulWidget {
  const FilterRequestSelfDialog({super.key, required this.sendData});

  final ValueChanged<FilterDialogModel> sendData;

  @override
  State<FilterRequestSelfDialog> createState() => _FilterRequestSelfDialogState();
}

class _FilterRequestSelfDialogState extends State<FilterRequestSelfDialog> {
  String startTime = DateFormat('yyyy-MM-dd').format(DateTime.now()),
      endTime = DateFormat('yyyy-MM-dd').format(DateTime.now()),
      errorTime = '',
      flowName = '',
      flowId = '';
  List<StatusRequestEnum> statuses = [];

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
    startTime = formatYMD(value.toString());
  }

  void setEndTime({required DateTime value}) {
    endTime = formatYMD(value.toString());
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
                  Row(
                    children: [
                      Text(
                        appLocalizations.type,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: SpacingUnit.x3,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _showBottomSheet(context),
                        child: Icon(
                          Icons.add_circle_outlined,
                          size: SpacingUnit.x7,
                          color: colors.success,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: SpacingUnit.x3),
                  Text(
                    flowName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: SpacingUnit.x3,
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
      ),
    );
  }

  setApply() {
    widget.sendData.call(FilterDialogModel(
        flowId: flowId, endTime: endTime, startTime: startTime, statuses: statuses));
    popDialog(context);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetFlowWidget(
          onChange: (value) => setFlow(value),
        );
      },
    );
  }

  setFlow(FlowRequest value) {
    setState(() {
      flowId = value.id;
      flowName = value.name ?? "";
    });
  }
}
