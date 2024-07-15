import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemMyRequisitionList extends StatelessWidget {
  const ContentItemMyRequisitionList({super.key, required this.id});

  final String id;

  Request _request(List<Request> requisitions, String id) {
    return requisitions.firstWhere((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.8,
              child: Text(
                _request(state.requisitions, id).flowType.configTypeName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w700),
              ),
            ),
            TitleValueLeave(
              title: appLocalizations.creator,
              value: _request(state.requisitions, id).createdFullName,
            ),
            TitleValueLeave(
              title: appLocalizations.createTime,
              value: formatYMDHMS(
                dateTimeLocal(_request(state.requisitions, id).createdDate).toString(),
              ),
            ),
            TitleValueLeave(
              title: appLocalizations.code,
              value: _request(state.requisitions, id).code,
              color: colors.success,
            ),
          ],
        );
      },
    );
  }
}
