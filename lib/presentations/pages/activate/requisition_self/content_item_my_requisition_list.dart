import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_icon_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemMyRequisitionList extends StatelessWidget {
  const ContentItemMyRequisitionList({super.key, required this.id, this.self = false});

  final String id;

  ///Có phải đơn của mình không
  final bool self;

  Request _request(List<Request> requisitions, String id) {
    return requisitions.firstWhere((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        final request = _request(state.requisitions, id);
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request.flowType.configTypeName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colors.text,
                  size: SpacingUnit.x6,
                ),
              ],
            ),
            if (self)
              TitleValueLeave(
                title: appLocalizations.creator,
                value: request.createdFullName,
              ),
            TitleValueLeave(
              title: appLocalizations.createTime,
              value: formatYMDHMS(
                dateTimeLocal(request.createdDate).toString(),
              ),
            ),
            TitleValueLeave(
              title: appLocalizations.code,
              value: request.code,
              color: colors.success,
            ),
            const SizedBox(
              height: SpacingUnit.x2,
            ),
            AppIconStatus(
              color: colors.text,
              icon: Assets.images.icon.work.loading,
              status: request.status.configRequestStatusName,
            ),
          ],
        );
      },
    );
  }

  Map<String, dynamic> statusRequest(
      {required BuildContext context, required StatusRequestEnum status}) {
    final colors = AppTheme.getColors(context);
    switch (status) {
      case StatusRequestEnum.process:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.reject:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.edit:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.approve:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.cancel:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.overdueEdit:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.overdueApprove:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
    }
  }
}
