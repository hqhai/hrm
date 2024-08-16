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
            final request = state.requisition;
            final workShiftSettings = request.config.workShiftSettings ?? [];
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
                    title: appLocalizations.selectTypeLeave,
                    value: request.config.takeLeaveType.configTakeLeaveTypeName,
                  ),
                  if (request.config.reasonLeave != null)
                    ItemTitleValue(
                      size: SpacingUnit.x4,
                      title: request.config.takeLeaveType ==
                              EnumTakeLeaveType.yearlyLeaveAndSeniorityLeave
                          ? appLocalizations.slectLeave
                          : appLocalizations.reason,
                      value: request.config.reasonLeave?.configEnumTakeLeaveName ?? "",
                    ),
                  if (request.config.socialInsuranceLeave != null)
                    ItemTitleValue(
                      size: SpacingUnit.x4,
                      title: appLocalizations.reason,
                      value: request.config.socialInsuranceLeave
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
                  if (workShiftSettings.isNotEmpty)
                    ShiftWidget(
                      context: context,
                      title: appLocalizations.firstShift,
                      workShift: workShiftSettings.first,
                    ),
                  if (workShiftSettings.length > 1)
                    ShiftWidget(
                      context: context,
                      title: appLocalizations.lastShift,
                      workShift: workShiftSettings.last,
                    ),
                  ItemTitleValue(
                    size: SpacingUnit.x4,
                    title: appLocalizations.totalLeaveWork,
                    value: (request.config.numberValue ?? 0).toString(),
                  ),
                  ItemTitleValueColum(
                    size: SpacingUnit.x4,
                    title: appLocalizations.description,
                    value: request.config.description ?? "",
                  ),
                  if (request.config.subtitudePersons?.isNotEmpty ?? false)
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
