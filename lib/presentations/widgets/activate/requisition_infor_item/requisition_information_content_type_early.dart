import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_list_over_time.dart';
import 'package:base_app/presentations/widgets/activate/leave/shift_widget.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeEarly extends StatefulWidget {
  const RequisitionInformationContentTypeEarly({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeEarly> createState() =>
      _RequisitionInformationContentTypeEarlyState();
}

class _RequisitionInformationContentTypeEarlyState
    extends State<RequisitionInformationContentTypeEarly> {
  List<bool> listCheck = [];

  @override
  void initState() {
    final Request request = dI<RequisitionBloc>().state.requisition;
    listCheck = List.filled(request.config.overTimes?.length ?? 0, true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        final workShiftSettings = state.requisition.config.workShiftSettings;
        final replace = RequisitionOverTime(
          date: state.requisition.config.endDate,
          startTime: state.requisition.config.startTime,
          endTime: state.requisition.config.endTime,
        );
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTitleValue(
                size: SpacingUnit.x4,
                title: appLocalizations.caseL,
                value: state.requisition.config.explanationReason
                        ?.configEditTimekeepingName ??
                    "",
                font: FontWeight.w600,
              ),
              ItemTitleValue(
                size: SpacingUnit.x4,
                title: appLocalizations.reason,
                value:
                    state.requisition.config.reason?.configEnumReasonName ?? "",
                font: FontWeight.w600,
              ),
              ItemTitleValue(
                size: SpacingUnit.x4,
                title: appLocalizations.time,
                value: formatYMD(
                    (state.requisition.config.startDate ?? "").toString()),
                font: FontWeight.w600,
              ),
              Text(
                appLocalizations.timeWorking,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (workShiftSettings.isNotEmpty)
                ...workShiftSettings.map(
                  (e) => ShiftWidget(
                    context: context,
                    title: "",
                    workShift: e,
                    reason: state.requisition.config.explanationReason,
                  ),
                ),
              if (state.requisition.config.explanationReason ==
                  EditTimekeeping.early) ...[
                Text(
                  appLocalizations.workOffset,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                ItemListOverTime(
                  requisitionOverTime: replace,
                  index: 0,
                  checkType: RequestType.early,
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  checkSubmit(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }

  onClick(int index) {
    setState(() {
      listCheck[index] = !listCheck[index];
    });
  }

  buildWhen(Request requisition, Request requisition2) {
    final check = requisition != requisition2;
    return check;
  }
}
