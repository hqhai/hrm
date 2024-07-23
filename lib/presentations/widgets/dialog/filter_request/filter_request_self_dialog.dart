import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/button_request.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/warp_in_dialog.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/explanation/item_create_timm_ymd.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/item_add.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_flow.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FilterRequestSelfDialog extends StatefulWidget {
  const FilterRequestSelfDialog({super.key, required this.sendData, this.filter});

  final ValueChanged<FilterDialogModel> sendData;
  final FilterDialogModel? filter;

  @override
  State<FilterRequestSelfDialog> createState() => _FilterRequestSelfDialogState();
}

class _FilterRequestSelfDialogState extends State<FilterRequestSelfDialog> {
  String errorTime = '', flowName = '', flowId = '';
  DateTime startTime = DateTime.now(), endTime = DateTime.now();
  List<StatusRequestEnum> statuses = [];

  @override
  void initState() {
    if (widget.filter != null) {
      startTime = widget.filter!.startTime ?? DateTime.now();
      endTime = widget.filter!.endTime ?? DateTime.now();
      statuses = widget.filter!.statuses ?? [];
      flowName = widget.filter!.flowName ?? '';
    }
    super.initState();
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
              child: Text(
                appLocalizations.filter,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: SpacingUnit.x4),
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
                  ItemAdd(
                    callback: () => _showBottomSheet(context),
                    title: appLocalizations.type,
                  ),
                  Text(
                    flowName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: SpacingUnit.x3,
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

  setApply(BuildContext context) {
    widget.sendData.call(FilterDialogModel(
      flowId: flowId,
      endTime: endTime,
      startTime: startTime,
      statuses: statuses,
      flowName: flowName,
    ));
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

  setReject(BuildContext context) {
    widget.sendData.call(const FilterDialogModel());
    popDialog(context);
  }
}
