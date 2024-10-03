import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';

class ContentRequisition extends StatelessWidget {
  final Request request;

  const ContentRequisition({
    super.key,
    required this.request,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
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
      ],
    );
  }
}
