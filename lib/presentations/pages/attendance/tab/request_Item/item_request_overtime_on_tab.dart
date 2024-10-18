import 'package:base_app/common/enum/enum_request.dart';
import 'package:base_app/common/enum/requisition_enum.dart';

import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/next_screen_request_information.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:base_app/domain/entities/requisition/requisition_over_time.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/request_history_work_sheet/request_work_sheet_state.dart';
import 'package:base_app/presentations/pages/activate/leave/title_value_leave.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_request_on_tab_common.dart';
import 'package:base_app/presentations/pages/attendance/tab/request_Item/item_type_on_tab.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemRequestOverTimeOnTab extends StatefulWidget {
  const ItemRequestOverTimeOnTab({
    super.key,
    required this.id,
    required this.dateTime,
  });

  final String id;
  final DateTime dateTime;

  @override
  State<ItemRequestOverTimeOnTab> createState() =>
      _ItemRequestOverTimeOnTabState();
}

class _ItemRequestOverTimeOnTabState extends State<ItemRequestOverTimeOnTab> {
  bool checkOpacity = false;

  Request requestById(List<Request> requests) {
    return requests.firstWhere((element) => element.id == widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
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
              const SizedBox(
                height: SpacingUnit.x4,
              ),
              Text(
                '${appLocalizations.timeFrameOT} :',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              ...setOTTime(request.config.overTimes, context).map(
                (e) => Row(
                  children: [
                    SvgPicture.asset(
                      Assets.images.icon.home.worksheet.dot,
                      colorFilter:
                          ColorFilter.mode(colors.text, BlendMode.srcIn),
                    ),
                    const SizedBox(
                      width: SpacingUnit.x2,
                    ),
                    Text(
                      e,
                      style: const TextStyle(
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ],
                ),
              ),
              TitleValueLeave(
                flexTitle: 2,
                flexValue: 1,
                font: FontWeight.w600,
                title: appLocalizations.totalOTHours,
                value: setTotalOT(request.config.overTimes),
                size: SpacingUnit.x4,
                padding: SpacingUnit.x2,
              ),
              TitleValueLeave(
                flexTitle: 2,
                flexValue: 1,
                title: appLocalizations.statusRequest,
                value: request.status.getAppLocalizationName,
                size: SpacingUnit.x4,
                padding: SpacingUnit.x2,
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

  List<String> setOTTime(
      List<RequisitionOverTime>? overTimes, BuildContext context) {
    final listOT = overTimes ?? [];
    final List<String> shift = [];
    for (var item in listOT) {
      if (item.date?.day == widget.dateTime.day &&
          item.date?.month == widget.dateTime.month) {
        final startTime = strSeconds(item.startTime);
        final endTime = strSeconds(item.endTime);
        shift.add('$startTime - $endTime  ');
      }
    }
    return shift;
  }

  String setTotalOT(List<RequisitionOverTime>? overTimes) {
    final listOT = overTimes ?? [];
    double time = 0;
    for (var item in listOT) {
      if (item.date?.day == widget.dateTime.day &&
          item.date?.month == widget.dateTime.month) {
        time = time + (item.suggestTime).toDouble();
      }
    }
    return strTimeFromInt(time.toInt());
  }
}
