import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/filter_dialog_model.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/requisition_self/button_request.dart';
import 'package:base_app/presentations/widgets/custom/period_time_picker.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/list_checkbox_flow_request_filter.dart';
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
  String errorTime = '';
  DateTime? startTime, endTime;
  StatusRequestEnum status = StatusRequestEnum.process;
  List<FlowRequest> flows = [];

  @override
  void initState() {
    if (widget.filter != null) {
      startTime = widget.filter!.startTime;
      endTime = widget.filter!.endTime;
      flows = widget.filter!.flows ?? [];
      status = widget.filter!.status ?? StatusRequestEnum.process;
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
            child: ListCheckboxFlowRequestFilter(
              listFlows: flows,
              onChange: (value) => _setListFlow(value),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(SpacingUnit.x2),
              child: PeriodTimePicker(
                oldStarTime: startTime,
                oldEndTime: endTime,
                title: appLocalizations.timeFrame,
                setStarTime: (value) => setStartTime(value: value),
                setEndTime: (value) => setEndTime(value: value),
              )),
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

  void setStartTime({DateTime? value}) {
    startTime = value;
  }

  void setEndTime({DateTime? value}) {
    endTime = value;
  }

  setApply(BuildContext context) {
    widget.sendData.call(FilterDialogModel(
      flows: flows,
      endTime: endTime,
      startTime: startTime,
      status: status,
    ));
    popDialog(context);
  }

  setReject(BuildContext context) {
    widget.sendData.call(const FilterDialogModel());
    popDialog(context);
  }

  close(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  _setListFlow(List<FlowRequest> value) {
    setState(() {
      flows = value;
    });
  }
}
