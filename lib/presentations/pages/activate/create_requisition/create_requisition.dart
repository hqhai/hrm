import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/navigator_extra/information_request_extra.dart';
import 'package:base_app/domain/entities/reqisition/flow.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_state.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
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
  int pageIndex = 1, totalItems = 0, lengthList = 0;
  FlowStatusEnum status = FlowStatusEnum.init;

  @override
  void initState() {
    dI<FlowBloc>().add(const GetFlowsEvent());
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
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
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
          return SingleChildScrollView(
            child: Container(
              width: width,
              height: height * 0.85,
              color: colors.surface,
              padding: const EdgeInsets.all(SpacingUnit.x4),
              margin: const EdgeInsets.all(SpacingUnit.x4),
              child: state.statusGet == FlowStatusEnum.init && state.flows.isEmpty
                  ? Center(
                      child: SizedBox(
                      height: SpacingUnit.x50,
                      width: SpacingUnit.x50,
                      child: Lottie.asset(Assets.images.icon.loading,
                          width: SpacingUnit.x50, height: SpacingUnit.x50, fit: BoxFit.fill),
                    ))
                  : ListView.builder(
                      controller: controller,
                      itemCount: state.flows.length,
                      itemBuilder: (context, index) => ItemActivateWidget(
                        title: _setTitle(context, state, index),
                        callback: () => _nextScreen(context, state.flows[index]),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  String _setTitle(BuildContext context, FlowState state, int index) {
    return state.flows[index].name ?? "";
  }

  _push({
    RequisitionTypeEnum? type,
    required BuildContext context,
    required String page,
    required InformationRequestExtra informationRequestExtra,
  }) async {

    final extraData = informationRequestExtra.toJson();
    final currentContext =  dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dI<FlowBloc>().add(GetFlowEvent(id: informationRequestExtra.flowId, completer: completer));
    final checkCompleter = await completer.future;
    if(type != null && checkCompleter) {
      extraData.addAll({'type': type});
      if(!currentContext.mounted) return;
      dI<AppNavigation>().pushName(
          context,
          page: page,
          extra: extraData
      );
    }
    else if(checkCompleter){
      if(!currentContext.mounted) return;
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
      case RequisitionTypeEnum.lateArrival:
        _push(
          type: RequisitionTypeEnum.lateArrival,
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
      case RequisitionTypeEnum.yearlyAndSeniorityLeave:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.yearlyAndSeniorityLeave,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.compensatoryLeave:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.compensatoryLeave,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.otherLeave:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.otherLeave,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.unpaidLeave:
        _push(
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          type: RequisitionTypeEnum.unpaidLeave,
          page: Pages.createRequestLeavePage,
        );
      case RequisitionTypeEnum.earlyDeparture:
        _push(
          type: RequisitionTypeEnum.earlyDeparture,
          context: context,
          informationRequestExtra: InformationRequestExtra(flowId: flow.id),
          page: Pages.createRequestLateAndEarlyPage,
        );
      case RequisitionTypeEnum.core:
      case null:
    }
  }
}
