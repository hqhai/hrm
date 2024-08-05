import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_approve/requisition_approve_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_icon_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemRequestApproveList extends StatelessWidget {
  const ContentItemRequestApproveList({super.key, required this.id, this.self = false, required this.status});
  final EnumStepRequestStatusEnum status;
  final String id;

  ///Có phải đơn của mình không
  final bool self;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionApproveBloc, RequisitionApproveState>(
      builder: (context, state) {
        final request = state.requisitions[id];
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  request?.flowType.configTypeName ?? "",
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
            const SizedBox(
              height: SpacingUnit.x2,
            ),
            AppIconStatus(
              color: statusRequest(context: context)['color'],
              icon: statusRequest(context: context)['icon'],
              status: status.configStepRequestStatusName,
            ),
          ],
        );
      },
    );
  }

  Map<String, dynamic> statusRequest(
      {required BuildContext context,}) {
    final colors = AppTheme.getColors(context);
    switch (status) {
      case EnumStepRequestStatusEnum.newStatus:
        return {
          'color': colors.goldenPurple,
          'icon': Assets.images.icon.work.loading,
        };
      case EnumStepRequestStatusEnum.reject:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.loading,
        };
      case EnumStepRequestStatusEnum.edit:
        return {
          'color': colors.tertiary,
          'icon': Assets.images.icon.work.edit,
        };
      case EnumStepRequestStatusEnum.approve:
        return {
          'color': colors.success,
          'icon': Assets.images.icon.work.success,
        };
      case EnumStepRequestStatusEnum.cancel:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.reject,
        };
      case EnumStepRequestStatusEnum.overdueApprove:
        return {
          'color': colors.error,
          'icon': Assets.images.icon.work.outDate,
        };
    }
  }
}
