import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemFollowingRequisitionList extends StatelessWidget {
  const ContentItemFollowingRequisitionList({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<RequisitionFollowingBloc, RequisitionFollowingState>(
      builder: (context, state) {
        final request = state.requisitions[id];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: width * 0.8,
              child: Text(
                request?.config.description ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w700),
              ),
            ),
            TitleValueLeave(
              title: appLocalizations.creator,
              value: request?.createdFullName ?? "",
            ),
            TitleValueLeave(
              title: appLocalizations.createTime,
              value: formatYMDHMS(
                dateTimeLocal(request?.createdDate).toString(),
              ),
            ),
            TitleValueLeave(
              title: appLocalizations.code,
              value: request?.code ?? "",
              color: colors.success,
            ),
          ],
        );
      },
    );
  }
}
