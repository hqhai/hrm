import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/navigator_extra/information_request_extra.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_bloc.dart';
import 'package:base_app/presentations/bloc/leave/work_and_salary/work_and_salary_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequestPageRoute = GoRoute(
  path: Pages.createRequestPage,
  name: Pages.createRequestPage,
  builder: (context, GoRouterState state) => const CreateRequestPage(),
);

class CreateRequestPage extends StatefulWidget {
  const CreateRequestPage({super.key});

  @override
  State<CreateRequestPage> createState() => _CreateRequestPageState();
}

class _CreateRequestPageState extends State<CreateRequestPage> {
  late ScrollController controller;
  int pageIndex = 1, totalItems = 12, lengthList = 11;
  FlowStatusEnum status = FlowStatusEnum.init;

  @override
  void initState() {
    controller = ScrollController()..addListener(_scrollListener);
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

  _listener(BuildContext context, FlowState state) {
    setState(() {
      status = state.statusGet;
      totalItems = state.totalItems;
      lengthList = state.flows.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(
          appLocalizations.createANewSingleWord,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: BlocConsumer<FlowBloc, FlowState>(
        listener: (context, state) => _listener(context, state),
        builder: (context, state) {
          return Container(
            color: colors.background,
            padding: const EdgeInsets.all(SpacingUnit.x4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
                  child: Text(
                    appLocalizations.chooseARequest,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: state.flows.length,
                    itemBuilder: (context, index) => InkWell(
                      onTap: () => _nextScreen(
                        context,
                        state.flows[index],
                      ),
                      child: item(
                        title: state.flows[index].flowType?.configTypeName ?? "",
                        context: context,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget item({required String title, required BuildContext context}) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 10,
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x2),
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: SpacingUnit.x5),
                  child: Center(
                    child: Icon(
                      Icons.chevron_right_outlined,
                      color: colors.text,
                      size: SpacingUnit.x6,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: colors.text.withOpacity(0.2),
        )
      ],
    );
  }

  _push({
    RequisitionTypeEnum? type,
    required BuildContext context,
    required String page,
    required InformationRequestExtra informationRequestExtra,
  }) async {
    final extraData = informationRequestExtra.toJson();
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    final Completer completerWorkAndSalary = Completer<bool>();
    dialogIndicator(
      context: context,
    );
    dI<WorkAndSalaryBloc>().add(
      GetTotalLeaveDayEvent(
        completer: completerWorkAndSalary,
      ),
    );
    dI<FlowBloc>().add(
      GetFlowEvent(
        id: informationRequestExtra.flowId,
        completer: completer,
      ),
    );
    final checkCompleter = await completer.future;
    final checkWorkAndSalary = await completerWorkAndSalary.future;
    if (type != null && checkCompleter && checkWorkAndSalary) {
      extraData.addAll({'type': type});
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pushName(context, page: page, extra: extraData);
    } else if (checkCompleter && checkWorkAndSalary) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pushName(
        context,
        page: page,
        extra: extraData,
      );
    }
  }

  _nextScreen(BuildContext context, FlowRequest flow) {
    switch (flow.flowType) {
      case RequisitionTypeEnum.explanation:
        _push(
          type: RequisitionTypeEnum.explanation,
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestExplanationPage,
        );
      case RequisitionTypeEnum.lateOrEarly:
        _push(
          type: RequisitionTypeEnum.lateOrEarly,
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestLateAndEarlyPage,
        );
      case RequisitionTypeEnum.overTime:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestOverTimePage,
        );
      case RequisitionTypeEnum.vehicleDriver:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestVehicleDispatchPage,
        );
      case RequisitionTypeEnum.postalDelivery:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestPostalDeliveryPage,
        );
      case RequisitionTypeEnum.warehouseReleased:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestReleaseOfWarehousePage,
        );
      case RequisitionTypeEnum.stationery:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestStationeryOderPage,
        );
      case RequisitionTypeEnum.bussiness:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestBusinessPage,
        );
      case RequisitionTypeEnum.leaveFiveDaysOrMore:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.leaveFiveDaysOrMore,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.leaveHalfDayToOneDay:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.leaveHalfDayToOneDay,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.leaveTwoDayToFourDay:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.leaveTwoDayToFourDay,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.makeUpWork:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.makeUpWork,
          page: Pages.createRequestMakeUpWorkPage,
        );
      case RequisitionTypeEnum.core:
      case null:
      case RequisitionTypeEnum.unknown:
      default:
    }
  }
}
