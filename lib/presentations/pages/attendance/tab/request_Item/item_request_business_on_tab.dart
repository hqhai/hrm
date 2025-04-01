import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';
import 'package:base_app/presentations/widgets/activate/requisition_info_item/item/item_title_value_no_border_colum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemRequestBusinessOnTab extends StatefulWidget {
  const ItemRequestBusinessOnTab({
    super.key,
    required this.id,
  });

  final String id;

  @override
  State<ItemRequestBusinessOnTab> createState() =>
      _ItemRequestBusinessOnTabState();
}

class _ItemRequestBusinessOnTabState extends State<ItemRequestBusinessOnTab> {
  bool checkOpacity = false;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return ItemRequestOnTabCommon(
      checkOpacity: checkOpacity,
      child: BlocBuilder<RequestWorkSheetBloc, RequestWorkSheetState>(
        builder: (context, state) {
          final request = state.mapRequests[widget.id] ?? const Request(id: '');
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemTypeOnTab(
                type: request.flowType.configTypeName,
                callback: () => nextScreenRequest(
                    context: context,
                    checkUser: RequestSeeByWho.user,
                    id: widget.id,
                    checkOpacity: checkOpacity,
                    setState: () => setOpacity()),
              ),
              ItemTitleValueNoBorderColum(
                font: FontWeight.w600,
                title: appLocalizations.titleBusiness,
                value: intervalOnLeave(
                    request.config.startDate, request.config.endDate),
                size: SpacingUnit.x4,
                leftPadding: 0,
              ),
              TitleValueLeave(
                font: FontWeight.w600,
                title: appLocalizations.numberTotalWork,
                value: request.config.numberValue.toString(),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
              ),
              TitleValueLeave(
                title: appLocalizations.statusRequest,
                value: request.status.getAppLocalizationName,
                size: SpacingUnit.x4,
                padding: SpacingUnit.x3,
                font: FontWeight.w600,
              ),
            ],
          );
        },
      ),
    );
  }

  setOpacity() {
    setState(() {
      checkOpacity = !checkOpacity;
    });
  }
}
