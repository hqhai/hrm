import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisiton_following/requisition_following_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/dialog_requisition_over_time.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/requisition_over_time_widget.dart';
import 'package:base_app/presentations/widgets/custom/app_icon_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ContentItemRequestFollowerList extends StatelessWidget {
  const ContentItemRequestFollowerList({
    super.key,
    required this.id,
  });

  final String id;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<RequisitionFollowingBloc, RequisitionFollowingState>(
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
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                      fontWeight: FontWeight.w700),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colors.text,
                  size: SpacingUnit.x6,
                ),
              ],
            ),
            TitleValueLeave(
              size: SpacingUnit.x3_5,
              padding: SpacingUnit.x1_5,
              title: appLocalizations.creator,
              value: request?.createdFullName ?? "",
              color: colors.success,
            ),
            TitleValueLeave(
              size: SpacingUnit.x3_5,
              padding: SpacingUnit.x1_5,
              title: appLocalizations.createTime,
              value: formatYMDHMS(
                dateTimeLocal(request?.createdDate).toString(),
              ),
            ),
            TitleValueLeave(
              size: SpacingUnit.x3_5,
              padding: SpacingUnit.x1_5,
              title: appLocalizations.code,
              value: request?.code ?? "",
              color: colors.success,
            ),
            const SizedBox(
              height: SpacingUnit.x2,
            ),
            request?.config.overTimes != null
                ? RequisitionOverTimeBody(
                    data: request!.config.overTimes!,
                    onShowDialog: () {
                      showCustomDialog(
                        context: context,
                        data: request.config.overTimes,
                        onCancel: _cancelPop,
                      );
                    },
                    // onCancel: _cancelPop(context),
                  )
                : const SizedBox(),
            AppIconStatus(
              color: statusRequest(
                  context: context,
                  status:
                      request?.status ?? StatusRequestEnum.process)['color'],
              icon: statusRequest(
                  context: context,
                  status: request?.status ?? StatusRequestEnum.process)['icon'],
              status: request?.status.getAppLocalizationName ?? "",
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
      default:
        return {};
    }
  }
}

_cancelPop() {
  final currentContext = dI<AppNavigation>().navigatorKey.currentContext;
  dI<AppNavigation>().pop(currentContext);
}
