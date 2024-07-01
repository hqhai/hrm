import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemRequisitionList extends StatelessWidget {
  const ContentItemRequisitionList({super.key, required this.id});

  final String id;

  Request _request(List<Request> requisitions, String id) {
    return requisitions.firstWhere((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.7,
              child: Text(
                _request(state.requisitions, id).config.description ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: colors.text, fontSize: SpacingUnit.x3_5, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: SpacingUnit.x3_5),
            Row(
              children: [
                Text(
                  '${appLocalizations.creator} : ',
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                ),
                SizedBox(
                  width: width * 0.6,
                  child: Text(
                    _request(state.requisitions, id).createdFullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                  ),
                )
              ],
            ),
            Row(children: [
              Text(
                '${appLocalizations.createTime} : ',
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
              ),
              SizedBox(
                width: width * 0.6,
                child: Text(
                  formatYMDHMS(
                    dateTimeLocal(_request(state.requisitions, id).createdDate)
                        .toString(),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                ),
              )
            ]),
            Row(
              children: [
                Text(
                  '${appLocalizations.code} : ',
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
                ),
                SizedBox(
                  width: width * 0.6,
                  child: Text(
                    _request(state.requisitions, id).code,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: colors.success, fontSize: SpacingUnit.x3_5),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
