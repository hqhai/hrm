import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/flow_enum.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
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
  FlowStatusEnum status = FlowStatusEnum.getFlowsInit;

  @override
  void initState() {
    dI<FlowBloc>().add(const GetFlowsEvent());
    controller = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (lengthList <= totalItems &&
        status == FlowStatusEnum.getFlowsSuccess &&
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
      status = state.status;
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
              child: state.status == FlowStatusEnum.getFlowsSuccess
                  ? ListView.builder(
                      controller: controller,
                      itemCount: state.flows.length,
                      itemBuilder: (context, index) => ItemActivateWidget(
                        title: _setTitle(context, state, index),
                        callback: () => _nextScreen(context, state, index),
                      ),
                    )
                  : Center(
                      child: SizedBox(
                        height: SpacingUnit.x50,
                        width: SpacingUnit.x50,
                        child: Lottie.asset(Assets.images.icon.loading,
                            width: SpacingUnit.x50, height: SpacingUnit.x50, fit: BoxFit.fill),
                      ),
                    ),
            ),
          );
        },
      ),
    );
  }

  String _setTitle(BuildContext context, FlowState state, int index) {
    return state.flows[index].name??"";
  }

  _nextScreen(BuildContext context, FlowState state, int index) {
    if (state.flows[index].flowType == RequisitionTypeEnum.explanation) {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestExplanationPage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    } else if (state.flows[index].flowType == RequisitionTypeEnum.lateArrival) {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestLeavePage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    } else if (state.flows[index].flowType == RequisitionTypeEnum.overTime) {
    } else if (state.flows[index].flowType == RequisitionTypeEnum.vehicleDriver) {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestVehicleDispatchPage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    } else if (state.flows[index].flowType == RequisitionTypeEnum.postalDelivery) {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestPostalDeliveryPage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    } else if (state.flows[index].flowType == RequisitionTypeEnum.warehouseReleased) {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestReleaseOfWarehousePage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    } else if (state.flows[index].flowType == RequisitionTypeEnum.stationery) {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestStationeryOderPage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    } else {
      dI<AppNavigation>().pushName(
        context,
        page: Pages.createRequestBusinessPage,
        extra: {
          'flowId': state.flows[index].id,
        },
      );
    }
  }
}
