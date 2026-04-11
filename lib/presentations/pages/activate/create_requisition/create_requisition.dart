import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/navigator_extra/information_request_extra.dart';
import 'package:base_app/domain/entities/requisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/leave_shift/leave_shift_event.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/requisition/requisition_event.dart';
import 'package:base_app/presentations/widgets/dialog/no_connection/no_connection_dialog.dart';
import 'package:base_app/presentations/widgets/custom/app_loading_indicator.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestPageRoute = GoRoute(
  path: Pages.createRequestPage,
  name: Pages.createRequestPage,
  builder: (context, GoRouterState state) {
    if (state.uri.hasQuery) {
      final query = state.uri.queryParameters;
      final date = query['date'] ?? '';
      return CreateRequestPage(date: DateTime.parse(date));
    } else {
      return CreateRequestPage(date: DateTime.now());
    }
  },
);

/// Icon mapping for each request type.
IconData _iconForType(RequisitionTypeEnum type) {
  switch (type) {
    case RequisitionTypeEnum.explanation:
      return Icons.edit_note_rounded;
    case RequisitionTypeEnum.overTime:
      return Icons.more_time_rounded;
    case RequisitionTypeEnum.vehicleDriver:
      return Icons.directions_car_outlined;
    case RequisitionTypeEnum.postalDelivery:
      return Icons.local_shipping_outlined;
    case RequisitionTypeEnum.warehouseReleased:
      return Icons.warehouse_outlined;
    case RequisitionTypeEnum.stationery:
      return Icons.inventory_2_outlined;
    case RequisitionTypeEnum.bussiness:
      return Icons.flight_takeoff_rounded;
    case RequisitionTypeEnum.leaveHalfDayToOneDay:
      return Icons.event_busy_outlined;
    case RequisitionTypeEnum.leaveTwoDayToFourDay:
      return Icons.date_range_outlined;
    case RequisitionTypeEnum.leaveFiveDaysOrMore:
      return Icons.calendar_month_outlined;
    case RequisitionTypeEnum.lateOrEarly:
      return Icons.schedule_rounded;
    case RequisitionTypeEnum.makeUpWork:
      return Icons.update_rounded;
    default:
      return Icons.description_outlined;
  }
}

/// Color mapping for each request type.
Color _colorForType(RequisitionTypeEnum type) {
  switch (type) {
    case RequisitionTypeEnum.explanation:
      return Colors.blue;
    case RequisitionTypeEnum.overTime:
      return Colors.teal;
    case RequisitionTypeEnum.vehicleDriver:
      return Colors.indigo;
    case RequisitionTypeEnum.postalDelivery:
      return Colors.brown;
    case RequisitionTypeEnum.warehouseReleased:
      return Colors.blueGrey;
    case RequisitionTypeEnum.stationery:
      return Colors.cyan;
    case RequisitionTypeEnum.bussiness:
      return Colors.deepPurple;
    case RequisitionTypeEnum.leaveHalfDayToOneDay:
      return Colors.orange;
    case RequisitionTypeEnum.leaveTwoDayToFourDay:
      return Colors.amber.shade700;
    case RequisitionTypeEnum.leaveFiveDaysOrMore:
      return Colors.red;
    case RequisitionTypeEnum.lateOrEarly:
      return Colors.pink;
    case RequisitionTypeEnum.makeUpWork:
      return Colors.green;
    default:
      return Colors.grey;
  }
}

class CreateRequestPage extends StatefulWidget {
  final DateTime date;
  const CreateRequestPage({super.key, required this.date});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  FlowStatusEnum status = FlowStatusEnum.init;

  @override
  void initState() {
    // Do NOT reset FlowBloc here — flows were already loaded by the caller
    // (_nextCreateScreen). Resetting would clear them and leave this page
    // stuck on the loading spinner forever.
    dI<RequisitionBloc>().add(const ResetRequisitionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        surfaceTintColor: Colors.transparent,
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          l10n.createANewSingleWord,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<FlowBloc, FlowState>(
        listener: (context, state) {
          setState(() {
            status = state.statusGet;
          });
        },
        builder: (context, state) {
          if (state.flows.isEmpty && status != FlowStatusEnum.success) {
            return const Center(
              child: AppLoadingIndicator(),
            );
          }

          return Column(
            children: [
              // Header text at top
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  SpacingUnit.x4,
                  SpacingUnit.x4,
                  SpacingUnit.x4,
                  SpacingUnit.x2,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    l10n.chooseARequest,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: colors.text,
                    ),
                  ),
                ),
              ),
              // Grid of request type cards — scrollable, bottom-aligned
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: SpacingUnit.x4,
                    vertical: SpacingUnit.x2,
                  ),
                  itemCount: state.flows.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: SpacingUnit.x3,
                    mainAxisSpacing: SpacingUnit.x3,
                  ),
                  itemBuilder: (context, index) {
                    final flow = state.flows[index];
                    final type = flow.flowType;
                    final icon = _iconForType(type);
                    final color = _colorForType(type);

                    return _RequestTypeCard(
                      icon: icon,
                      color: color,
                      title: type.configTypeName,
                      onTap: () => _nextScreen(context, flow, widget.date),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ── Navigation logic (unchanged) ──

  _push({
    RequisitionTypeEnum? type,
    required BuildContext context,
    required String page,
    required InformationRequestExtra informationRequestExtra,
  }) async {
    final extraData = informationRequestExtra.toJson();
    if (type != null) {
      extraData.addAll({'type': type});
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pushName(context, page: page, extra: extraData);
    } else {
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pushName(context, page: page, extra: extraData);
    }
  }

  _nextScreen(BuildContext context, FlowRequest flow, DateTime date) async {
    dialogIndicator(context: context);
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final check = await _checkLoadScreen(flow);
    if (check) {
      if (!currentContext.mounted) return;
      switch (flow.flowType) {
        case RequisitionTypeEnum.explanation:
          _push(
            type: RequisitionTypeEnum.explanation,
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestExplanationPage,
          );
        case RequisitionTypeEnum.lateOrEarly:
          _push(
            type: RequisitionTypeEnum.lateOrEarly,
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestLateAndEarlyPage,
          );
        case RequisitionTypeEnum.overTime:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestOverTimePage,
          );
        case RequisitionTypeEnum.vehicleDriver:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestVehicleDispatchPage,
          );
        case RequisitionTypeEnum.postalDelivery:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestPostalDeliveryPage,
          );
        case RequisitionTypeEnum.warehouseReleased:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestReleaseOfWarehousePage,
          );
        case RequisitionTypeEnum.stationery:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestStationeryOderPage,
          );
        case RequisitionTypeEnum.bussiness:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            page: Pages.createRequestBusinessPage,
          );
        case RequisitionTypeEnum.leaveFiveDaysOrMore:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            type: RequisitionTypeEnum.leaveFiveDaysOrMore,
            page: Pages.createRequestLeavePage,
          );
        case RequisitionTypeEnum.leaveHalfDayToOneDay:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            type: RequisitionTypeEnum.leaveHalfDayToOneDay,
            page: Pages.createRequestLeavePage,
          );
        case RequisitionTypeEnum.leaveTwoDayToFourDay:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            type: RequisitionTypeEnum.leaveTwoDayToFourDay,
            page: Pages.createRequestLeavePage,
          );
        case RequisitionTypeEnum.makeUpWork:
          _push(
            context: currentContext,
            informationRequestExtra:
                InformationRequestExtra(flowId: flow.id, date: date),
            type: RequisitionTypeEnum.makeUpWork,
            page: Pages.createRequestMakeUpWorkPage,
          );
        case RequisitionTypeEnum.core:
        case RequisitionTypeEnum.unknown:
      }
    } else {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dialogNoConnection(context: currentContext);
    }
  }

  Future<bool> _loadFlow(FlowRequest flow) async {
    final Completer completer = Completer<bool>();
    dI<FlowBloc>().add(GetFlowEvent(id: flow.id, completer: completer));
    return await completer.future;
  }

  Future<bool> loadWorkAndSalary() async {
    final Completer completer = Completer<bool>();
    dI<WorkAndSalaryBloc>().add(GetTotalLeaveTypeEvent(completer: completer));
    return await completer.future;
  }

  Future<bool> loadWorkShiftOneDay() async {
    final Completer completer = Completer<bool>();
    dI<LeaveShiftBloc>().add(GetWorkShiftsEvent(
        endDate: DateTime.now(),
        startDate: DateTime.now(),
        completer: completer));
    return await completer.future;
  }

  Future<bool> _checkLoadScreen(FlowRequest flow) async {
    switch (flow.flowType) {
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        final checkF = await _loadFlow(flow);
        final checkWAS = await loadWorkAndSalary();
        return checkF && checkWAS;
      case RequisitionTypeEnum.lateOrEarly:
      case RequisitionTypeEnum.makeUpWork:
        final checkF = await _loadFlow(flow);
        final checkWS = await loadWorkShiftOneDay();
        return checkF && checkWS;
      default:
        return await _loadFlow(flow);
    }
  }
}

// ---------------------------------------------------------------------------
// Request Type Card
// ---------------------------------------------------------------------------

class _RequestTypeCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final VoidCallback onTap;

  const _RequestTypeCard({
    required this.icon,
    required this.color,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(SpacingUnit.x4),
          border: Border.all(color: color.withValues(alpha: 0.12)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(SpacingUnit.x3),
              ),
              child: Icon(icon, color: color, size: 26),
            ),
            const SizedBox(height: SpacingUnit.x2),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                color: colors.text,
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
