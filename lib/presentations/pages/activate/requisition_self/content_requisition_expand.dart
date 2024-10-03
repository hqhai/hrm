import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/requisition/step_request_approvers.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';

class ContentRequisitionExpand extends StatelessWidget {
  final Request request;

  const ContentRequisitionExpand({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final stepApprove = _getStepRequestApprove();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x1_5,
          title: appLocalizations.creator,
          value: request.createdFullName,
        ),
        TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x1_5,
          title: appLocalizations.createTime,
          value: formatYMDHMS(
            dateTimeLocal(request.createdDate).toString(),
          ),
        ),
        TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x1_5,
          title: appLocalizations.code,
          value: request.code,
        ),
        TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x1_5,
          title: _getTitleRequestBy(),
          value: stepApprove.nameApprover,
        ),
        TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x1_5,
          title: appLocalizations.department,
          value: stepApprove.nameApproverDepartment,
        ),
        TitleValueLeave(
          size: SpacingUnit.x3_5,
          padding: SpacingUnit.x1_5,
          title: appLocalizations.position,
          value: stepApprove.nameApproverPosition,
        ),
        const SizedBox(height: SpacingUnit.x1_5),
        Text(
          _getTitleReason(),
          style: const TextStyle(
            fontSize: 14,
          ),
        ),
        const SizedBox(height: SpacingUnit.x1),
        Text(
          stepApprove.note,
          style: const TextStyle(fontSize: 14),
        )
      ],
    );
  }

  StepRequestApprovers _getStepRequestApprove() {
    for (var stepRequest in request.stepRequests) {
      for (var stepApprove in stepRequest.stepRequestApprovers) {
        if (stepApprove.status.name == request.status.name) {
          return stepApprove;
        }
      }
    }
    return const StepRequestApprovers(id: '');
  }

  String _getTitleRequestBy() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    if (request.status == StatusRequestEnum.reject) {
      return appLocalizations.requestDeniedBy;
    } else if (request.status == StatusRequestEnum.cancel) {
      return appLocalizations.requestCancelBy;
    } else if (request.status == StatusRequestEnum.edit) {
      return appLocalizations.requestEditBy;
    }

    return '';
  }

  String _getTitleReason() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final appLocalizations = AppLocalizations.of(currentContext)!;
    if (request.status == StatusRequestEnum.reject) {
      return appLocalizations.reasonReject;
    } else if (request.status == StatusRequestEnum.cancel) {
      return appLocalizations.reasonCancel;
    } else if (request.status == StatusRequestEnum.edit) {
      return "${appLocalizations.reason}:";
    }

    return '';
  }
}
