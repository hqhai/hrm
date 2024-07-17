
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/item_data.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class CalendarWorkWidget extends StatefulWidget {
  const CalendarWorkWidget({super.key});

  @override
  State<CalendarWorkWidget> createState() => _CalendarWorkWidgetState();
}

class _CalendarWorkWidgetState extends State<CalendarWorkWidget> {
  @override
  Widget build(BuildContext context) {
    return ContainerScreenMain(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: listCalendarWork
              .mapIndexed(
                (index, element) => ItemActivateWidget(
                  title: titlesCalendarWork(index, context),
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
        _nextRegisterShiftsScreen(context);
      case 1:
        _nextCreateRequisitionScreen(context);
    }
  }

  _nextRegisterShiftsScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.registerShiftsPage);
  }

  _nextCreateRequisitionScreen(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.createRequestPage);
  }

}
