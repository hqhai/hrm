
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/item_data.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class ActivateWidget extends StatefulWidget {
  const ActivateWidget({super.key});

  @override
  State<ActivateWidget> createState() => _ActivateWidgetState();
}

class _ActivateWidgetState extends State<ActivateWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerScreenMain(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: listActivate
              .mapIndexed(
                (index, element) => ItemActivateWidget(
                  iconPath: imagePathActivate(index),
                  title: titlesActivate(index, context),
                  callback: () => _nextScreen(context, index),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  _nextScreen(BuildContext context, int index) {
    switch (index) {
      case 0:
        _nextRequisitionListScreen(context);
      case 1:
        _nextCreateRequisitionScreen(context);
      case 2:
        _nextTimekeepingGPSScreen(context);
      case 3:
        _nextTimekeepingGPSScreen(context);
      case 4:
        _nextTimekeepingGPSScreen(context);
    }
  }

  _nextRequisitionListScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.seeRequestListPage);
  }

  _nextCreateRequisitionScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestPage);
  }

  _nextTimekeepingGPSScreen(BuildContext context) async {
    dI<AppNavigation>().pushName(
      context,
      page: Pages.listSchoolsPage,
    );
  }
}
