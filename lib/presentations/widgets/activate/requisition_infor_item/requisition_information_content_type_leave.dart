import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_bloc.dart';
import 'package:base_app/presentations/bloc/user/user_by_id/user_by_id_state.dart';
import 'package:base_app/presentations/widgets/activate/leave/shift_widget.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_person_information_request.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RequisitionInformationContentTypeLeave extends StatefulWidget {
  const RequisitionInformationContentTypeLeave({
    super.key,
  });

  @override
  State<RequisitionInformationContentTypeLeave> createState() =>
      _RequisitionInformationContentTypeLeaveState();
}

class _RequisitionInformationContentTypeLeaveState
    extends State<RequisitionInformationContentTypeLeave> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<UserByIdBloc, UserByIdState>(
      builder: (context, stateUserById) {
        return BlocBuilder<RequisitionBloc, RequisitionState>(
          builder: (context, state) {
            final workShiftSettings = state.requisition.config.workShiftSettings ?? [];
            workShiftSettings.sort((a, b) {
              int dateComparison = a.workDate.compareTo(b.workDate);
              if (dateComparison != 0) {
                return dateComparison;
              } else {
                return a.startTime.compareTo(b.startTime);
              }
            });
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    appLocalizations.contentOfApplication,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.detailedReason,
                    value: state.requisition.config.takeLeaveType.configTakeLeaveTypeName,
                  ),
                  if (state.requisition.config.reasonLeave != null)
                    ItemTitleValue(
                      size: SpacingUnit.x4,
                      title: appLocalizations.reason,
                      value: state.requisition.config.reasonLeave?.configEnumTakeLeaveName ?? "",
                    ),
                  if (state.requisition.config.socialInsuranceLeave != null)
                    ItemTitleValue(
                      size: SpacingUnit.x4,
                      title: appLocalizations.reason,
                      value: state.requisition.config.socialInsuranceLeave
                              ?.configSocialInsuranceLeaveName ??
                          "",
                    ),
                  Padding(
                    padding: const EdgeInsets.only(top: SpacingUnit.x2),
                    child: Text(
                      appLocalizations.intervalOnLeave,
                      style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ),
                  ShiftWidget(
                    context: context,
                    title: appLocalizations.firstShift,
                    workShift: workShiftSettings.first,
                  ),
                  ShiftWidget(
                    context: context,
                    title: appLocalizations.lastShift,
                    workShift: workShiftSettings.last,
                  ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.totalLeaveWork,
                    value: (state.requisition.config.numberValue ?? 0).toString(),
                  ),
                  ItemTitleValueColum(
                    size: SpacingUnit.x4,
                    title: appLocalizations.description,
                    value: state.requisition.config.description ?? "",
                  ),
                  if (state.requisition.config.subtitudePersons?.isNotEmpty ?? false)
                    ItemPersonInformationRequest(
                      title: appLocalizations.substitute,
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
