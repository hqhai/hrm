import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:flutter/material.dart';
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
                callback: () => _nextCreateRequestExplanationScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.leave,
                callback: () => _nextCreateRequestOnLeaveScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.overtime,
                callback: () {},
              ),
              ItemActivateWidget(
                title: appLocalizations.vehicleDispatch,
                callback: () => _nextCreateRequestVehicleDispatchScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.postalDelivery,
                callback: () => _nextCreateRequestPostalDeliveryScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.releaseOfWarehouse,
                callback: () => _nextCreateRequestReleaseOfWarehouseScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.stationeryOrder,
                callback: () => _nextCreateRequestStationeryOrderScreen(context),
              ),
              ItemActivateWidget(
                title: appLocalizations.business,
                callback: () => _nextCreateRequestBusinessScreen(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _nextCreateRequestExplanationScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestExplanationPage);
  }

  _nextCreateRequestOnLeaveScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestLeavePage);
  }

  _nextCreateRequestBusinessScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestBusinessPage);
  }

  _nextCreateRequestVehicleDispatchScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestVehicleDispatchPage);
  }

  _nextCreateRequestPostalDeliveryScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestPostalDeliveryPage);

  }

  _nextCreateRequestStationeryOrderScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestStationeryOderPage);
  }

  _nextCreateRequestReleaseOfWarehouseScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestReleaseOfWarehousePage);
  }
}
