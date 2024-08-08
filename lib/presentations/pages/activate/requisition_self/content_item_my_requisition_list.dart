import 'package:base_app/common/enum/enum_request.dart';
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
  const ContentItemMyRequisitionList({super.key, required this.id, required this.self});

  final String id;

  ///Có phải đơn của mình không
  final RequestSeeByWho self;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionBloc, RequisitionState>(
      builder: (context, state) {
        final request = state.requisitions[id] ?? const Request(id: '');
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: SpacingUnit.x2_5),
              child: Row(
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
            ),
            if (self != RequestSeeByWho.user)
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
              color: colors.success,
            ),
            Padding(
              padding: const EdgeInsets.only(top: SpacingUnit.x2_5),
              child: AppIconStatus(
                color: statusRequest(
                    context: context,
                    status: request.status)['color'],
                icon: statusRequest(
                    context: context, status: request.status)['icon'],
                status: request.status.configRequestStatusName,
              ),
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
          'color': colors.goldenPurple,
          'icon': Assets.images.icon.work.loading,
        };
      case StatusRequestEnum.reject:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.reject,
        };
      case StatusRequestEnum.edit:
        return {
          'color': colors.tertiary,
          'icon': Assets.images.icon.work.edit,
        };
      case StatusRequestEnum.approve:
        return {
          'color': colors.success,
          'icon': Assets.images.icon.work.success,
        };
      case StatusRequestEnum.cancel:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.reject,
        };
      case StatusRequestEnum.overdueEdit:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.outDate,
        };
      case StatusRequestEnum.overdueApprove:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.outDate,
        };
    }
  }
}
