import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_bloc.dart';
import 'package:base_app/presentations/bloc/requisition/flow/flow_event.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final seeRequestListPageRoute = GoRoute(
    path: Pages.seeRequestListPage,
    name: Pages.seeRequestListPage,
    builder: (context, GoRouterState state) => const SeeListRequisitionPage());

class SeeListRequisitionPage extends StatefulWidget {
  const SeeListRequisitionPage({super.key});

  @override
  State<SeeListRequisitionPage> createState() => _SeeListRequisitionPageState();
}

class _SeeListRequisitionPageState extends State<SeeListRequisitionPage> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(appLocalizations.singleWordList,
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x6)),
      ),
      body: ContainerScreenMain(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ItemActivateWidget(
              title: appLocalizations.yourRequisition,
              callback: () => _nextRequisitionListScreen(context),
            ),
            ItemActivateWidget(
              title: appLocalizations.requisitionYouApproval,
              callback: () => _nextRequisitionApproveListScreen(context),
            ),
            ItemActivateWidget(
                title: appLocalizations.requisitionYouFollow,
                callback: () => _nextRequisitionFollowerListScreen(context)),
          ],
        ),
      ),
    );
  }

  _nextRequisitionListScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    Completer completer = Completer<bool>();
    dI<FlowBloc>().add(GetFlowsEvent(completer: completer));
    final check = await completer.future;
    if (check) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>()
          .pushName(currentContext, page: Pages.requisitionListPage);
    }
  }

  _nextRequisitionApproveListScreen(BuildContext context) {
    dI<AppNavigation>()
        .pushName(context, page: Pages.requisitionApproveListPage);
  }

  _nextRequisitionFollowerListScreen(BuildContext context) {
    dI<AppNavigation>()
        .pushName(context, page: Pages.requisitionFollowerListPage);
  }
}
