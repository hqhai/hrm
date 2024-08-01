import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/work_shift_request.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/work_day_admin_query_params.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/domain/entities/work_day/work_day.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final registerWorkDayPageRoute = GoRoute(
  path: Pages.registerWorkDayAdmin,
  name: Pages.registerWorkDayAdmin,
  builder: (context, GoRouterState state) => const RegisterWorkDayAdminPage(),
);

class RegisterWorkDayAdminPage extends StatefulWidget {
  const RegisterWorkDayAdminPage({super.key});

  @override
  State<RegisterWorkDayAdminPage> createState() =>
      _RegisterWorkDayAdminPageState();
}

class _RegisterWorkDayAdminPageState extends State<RegisterWorkDayAdminPage> {
  late ScrollController controller;
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  FlowStatusEnum status = FlowStatusEnum.init;
  WorkShiftRequestStatus selectType = WorkShiftRequestStatus.approve;

  @override
  void initState() {
    dI<FlowBloc>().add(const GetFlowsEvent());
    controller = ScrollController()..addListener(_scrollListener);
    dI<WorkDayBloc>().add(GetElectiveShift(
        data: WorkDayGetElectiveShiftRequest(
      isApprove: true,
      startDate: formatYMD(
          DateTime.now().subtract(const Duration(days: 30)).toString()),
      endDate: formatYMD(DateTime.now().toString()),
    )));
    super.initState();
  }

  _scrollListener() {
    if (lengthList < totalItems &&
        status == FlowStatusEnum.success &&
        controller.position.extentAfter < totalItems) {
      setState(() {
        pageIndex++;
      });
      dI<FlowBloc>().add(GetFlowsEvent(
        page: pageIndex,
      ));
    }
  }

  _onTapHeader(WorkShiftRequestStatus type) {
    switch (type) {
      case WorkShiftRequestStatus.approve:
        dI<WorkDayBloc>().add(GetElectiveShift(
            data: WorkDayGetElectiveShiftRequest(
          isApprove: true,
          startDate: formatYMD(
              DateTime.now().subtract(const Duration(days: 30)).toString()),
          endDate: formatYMD(DateTime.now().toString()),
        )));
        break;
      case WorkShiftRequestStatus.unusable:
        dI<WorkDayBloc>().add(GetElectiveShift(
            data: WorkDayGetElectiveShiftRequest(
          isApprove: false,
          startDate: formatYMD(
              DateTime.now().subtract(const Duration(days: 30)).toString()),
          endDate: formatYMD(DateTime.now().toString()),
        )));
        break;
      case WorkShiftRequestStatus.pendingCancel:
        dI<WorkDayBloc>().add(const GetWorkDayAdmin(
            data: WorkDayAdminRequest(
                requestStatus: WorkShiftRequestStatus.pendingCancel)));
        break;
      case WorkShiftRequestStatus.pending:
        dI<WorkDayBloc>().add(const GetWorkDayAdmin(
            data: WorkDayAdminRequest(
                requestStatus: WorkShiftRequestStatus.pending)));
        break;
      default:
        () {};
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.black,
            size: SpacingUnit.x8,
          ),
        ),
        title: Text(
          appLocalizations.createANewSingleWord,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocBuilder<WorkDayBloc, WorkDayState>(
        // listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Column(
            children: [
              SizedBox(
                height: SpacingUnit.x15,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        _onTapHeader(WorkShiftRequestStatus.values[index]);
                        setState(() {
                          selectType = WorkShiftRequestStatus.values[index];
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: const BorderSide(width: 0),
                                  bottom: selectType ==
                                          WorkShiftRequestStatus.values[index]
                                      ? BorderSide(
                                          width: 3,
                                          color: ColorUtils.parseHex('#808890'))
                                      : const BorderSide(width: 0))),
                          width: MediaQuery.sizeOf(context).width / 2.5,
                          child: Center(
                              child: Text(
                            WorkShiftRequestStatus
                                .values[index].configWorkShiftRequestStatusName,
                            style: theme.textTheme.titleMedium,
                          ))),
                    );
                  },
                ),
              ),
              if (selectType == WorkShiftRequestStatus.approve ||
                  selectType == WorkShiftRequestStatus.unusable) ...[
                if (state.electiveShiftItems.isEmpty) Container(),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  color: colors.surfaceVariantLow.withOpacity(0.1),
                  child: ListView.builder(
                    itemCount: state.electiveShiftItems.length,
                    itemBuilder: (context, index) => _Item(
                        state.electiveShiftItems[index], index, selectType),
                  ),
                ))
              ] else ...[
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  color: colors.surfaceVariantLow.withOpacity(0.1),
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) =>
                        _ItemPending(state.items[index], index, selectType),
                  ),
                ))
              ],
            ],
          );
        },
      ),
    );
  }
}

class _Item extends StatelessWidget {
  final int index;
  final UsableAdmin data;
  final WorkShiftRequestStatus type;
  const _Item(this.data, this.index, this.type);

  @override
  Widget build(BuildContext context) {
    // final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    // final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => dI<AppNavigation>().push(context,
          page: Pages.registerWorkDayAdminDetail,
          paramsQuerry: WorkDayAdminQueryParams(
                  workDayAdminIndex: index.toString(), type: type)
              .toJson()),
      child: Container(
        margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(data.workShiftRegisteredDetails.first.nameWorkShift,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
              const Icon(Icons.chevron_right)
            ]),
            const SizedBox(height: SpacingUnit.x3),
            Text(
                "Thời gian: ${strSeconds(data.workShiftRegisteredDetails.first.startTime)} - ${strSeconds(data.workShiftRegisteredDetails.first.endTime)} ${formatDMY(data.workDate.toString())}")
          ],
        ),
      ),
    );
  }
}

class _ItemPending extends StatelessWidget {
  final WorkDayAdmin data;
  final int index;
  final WorkShiftRequestStatus type;
  const _ItemPending(this.data, this.index, this.type);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    return InkWell(
      onTap: () => dI<AppNavigation>().push(context,
          page: Pages.registerWorkDayAdminDetail,
          paramsQuerry: WorkDayAdminQueryParams(
                  workDayAdminIndex: index.toString(), type: type)
              .toJson()),
      child: Container(
        margin: const EdgeInsets.only(bottom: SpacingUnit.x4),
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x3),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(data.nameWorkShift,
                  style: theme.textTheme.bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500)),
              Text(appLocalizations.seeDetails,
                  style: theme.textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.w500, color: Colors.blue)),
            ]),
            const SizedBox(height: SpacingUnit.x3),
            Text("${data.name} #${data.code}"),
            Text(
                "${appLocalizations.time}: ${strSeconds(data.startTime)} - ${strSeconds(data.endTime)} ${formatDMY(data.workDate.toString())}"),
            const SizedBox(height: SpacingUnit.x4),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: SpacingUnit.x10,
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: colors.outline.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(SpacingUnit.x2)),
                    child: Center(
                      child: Text(appLocalizations.reject,
                          style: theme.textTheme.bodyMedium!
                              .copyWith(fontWeight: FontWeight.w600)),
                    ),
                  ),
                ),
                const SizedBox(
                  width: SpacingUnit.x3,
                ),
                Expanded(
                  child: Container(
                    height: SpacingUnit.x10,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(SpacingUnit.x2)),
                    child: Center(
                      child: Text("Xác nhận",
                          style: theme.textTheme.bodyMedium!.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white)),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
