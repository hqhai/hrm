import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/widgets/custom/app_link_next_screen.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemRequestOnTab extends StatelessWidget {
  const ItemRequestOnTab({super.key, required this.id});

  final String id;

  Request requestById(List<Request> requests) {
    return requests.firstWhere((element) => element.id == id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocBuilder<RequestWorkSheetBloc, RequestWorkSheetState>(
      builder: (context, state) {
        final request = state.mapRequests[id];
        return ContainerBorder(
            borderColors: colors.surfaceVariantHigh,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        request?.flowType.configTypeName ?? "",
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: AppLinkNextScreen(
                        callback: () => _nextScreenRequest(context),
                      ),
                    )
                  ],
                ),
                TitleValueLeave(
                  title: appLocalizations.intervalOnLeave,
                  value: intervalOnLeave(request?.config.startDate, request?.config.endDate),
                  size: SpacingUnit.x4,
                  padding: SpacingUnit.x3,
                ),
                TitleValueLeave(
                  title: appLocalizations.typeRequest,
                  value: request?.flowType.configTypeName ?? "",
                  size: SpacingUnit.x4,
                  padding: SpacingUnit.x3,
                ),
                TitleValueLeave(
                  title: appLocalizations.reason,
                  value: request?.config.takeLeaveReason?.configEnumTakeLeaveName ?? "",
                  size: SpacingUnit.x4,
                  padding: SpacingUnit.x3,
                ),
                TitleValueLeave(
                  title: appLocalizations.totalLeaveWork,
                  value: '0',
                  size: SpacingUnit.x4,
                  padding: SpacingUnit.x3,
                ),
              ],
            ));
      },
    );
  }

  String intervalOnLeave(DateTime? startDate, DateTime? endDate) {
    String start = (startDate ?? '').toString();
    String end = (endDate ?? '').toString();
    return '${formatYMD(start)} - ${formatYMD(end)}';
  }

  _nextScreenRequest(BuildContext context) {}
}
