import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final createRequisitionPageRoute = GoRoute(
  path: Pages.createRequisitionPage,
  name: Pages.createRequisitionPage,
  builder: (context, GoRouterState state) => const CreateRequisitionPage(),
);

class CreateRequisitionPage extends StatefulWidget {
  const CreateRequisitionPage({super.key});

  @override
  State<CreateRequisitionPage> createState() => _CreateRequisitionPageState();
}

class _CreateRequisitionPageState extends State<CreateRequisitionPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
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
      body: SingleChildScrollView(
        child: Container(
          color: colors.surface,
          padding: const EdgeInsets.all(SpacingUnit.x4),
          margin: const EdgeInsets.all(SpacingUnit.x4),
          child: Column(
            children: [
              ItemActivateWidget(
                title: appLocalizations.explanation,
                callback: () => _nextCreateRequisitionExplanationScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.leave,
                callback: () => _nextCreateRequisitionOnLeaveScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.overtime,
                callback: () {},
              ),
              ItemActivateWidget(
                title: appLocalizations.vehicleDispatch,
                callback: () => _nextCreateRequisitionVehicleDispatchScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.postalDelivery,
                callback: () => _nextCreateRequisitionPostalDeliveryScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.releaseOfWarehouse,
                callback: () => _nextCreateRequisitionReleaseOfWarehouseScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.stationeryOrder,
                callback: () => _nextCreateRequisitionStationeryOrderScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.business,
                callback: () => _nextCreateRequisitionBusinessScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nextCreateRequisitionExplanationScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionExplanationPage);
  }

  _nextCreateRequisitionOnLeaveScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionLeavePage);
  }

  _nextCreateRequisitionBusinessScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionBusinessPage);
  }

  _nextCreateRequisitionVehicleDispatchScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionVehicleDispatchPage);
  }

  _nextCreateRequisitionPostalDeliveryScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionPostalDeliveryPage);

  }

  _nextCreateRequisitionStationeryOrderScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionStationeryOderPage);
  }

  _nextCreateRequisitionReleaseOfWarehouseScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequisitionReleaseOfWarehousePage);
  }
}
