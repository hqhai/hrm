import 'dart:core';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/pages/calendar_work/item_day_of_list.dart';
import 'package:base_app/presentations/pages/calendar_work/item_day_of_week.dart';
import 'package:base_app/presentations/pages/calendar_work/week_on_calendar.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:themes/themes.dart';

final registerShiftsPageRoute = GoRoute(
  path: Pages.registerShiftsPage,
  name: Pages.registerShiftsPage,
  builder: (context, GoRouterState state) => const RegisterShiftsPage(),
);

class RegisterShiftsPage extends StatefulWidget {
  const RegisterShiftsPage({super.key});

  @override
  State<RegisterShiftsPage> createState() => _RegisterShiftsPageState();
}

class _RegisterShiftsPageState extends State<RegisterShiftsPage> {
  DateTime currentDateTime = DateTime.now();
  List<DateTime> listDayBottom = [];
  double scrollOffset = 0.0;
  int indexLocal = 6;
  late ScrollController _scrollController;
  List<double> positions = [];

  @override
  void initState() {
    listDayBottom = [...listDays()];
    _scrollController = ScrollController();
    super.initState();
  }

  List<DateTime> listDays() {
    final int nowOfWeek = mapNumberDayInWeek[DateFormat('EEE').format(currentDateTime)] ?? 0;
    final DateTime startOfWeek = currentDateTime.subtract(Duration(days: nowOfWeek - 1));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 7));
    dI<WorkDayBloc>().add(GetWorkDaysEvent(startDate: startOfWeek, endDate: endOfWeek));
    List<DateTime> daysOfWeek = [];
    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      daysOfWeek.add(day);
    }
    return daysOfWeek;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.registerShift,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: ContainerScreenMain(
        padding: 0,
        margin: 0,
        child: Column(
          children: [
            WeekOnCalendar(
              currentDateTime: currentDateTime,
              downWeek: () => setDownWeek(),
              upWeek: () => setUpWeek(),
            ),
            Row(
              children: listDays()
                  .mapIndexed(
                    (index, element) => Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () => onClick(element),
                        child: ItemDayOfWeek(
                          index: index,
                          time: element,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: listDayBottom.length,
                itemBuilder: (context, index) => ItemDayOfList(
                  dateTime: listDayBottom[index],
                  type: (value) => _setPosition(value),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  setDownWeek() {
    setState(() {
      currentDateTime = currentDateTime.subtract(const Duration(days: 7));
      listDayBottom = [...listDays(),];
    });
  }

  setUpWeek() {
    setState(() {
      currentDateTime = currentDateTime.add(const Duration(days: 7));
      listDayBottom = [...listDays()];
    });
  }

  double positionByIndex(int index) {
    double sum = 0;
    for (int i = 0; i < index; i++) {
      sum += positions[i];
    }
    return sum;
  }

  onClick(DateTime date) {
    final index = listDayBottom.indexWhere((element) => element.isAtSameMomentAs(date));
    _scrollController.animateTo(
      positionByIndex(index),
      duration: const Duration(milliseconds: 300,),
      curve: Curves.linear,
    );
  }

  Widget load() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(Assets.images.icon.loading,
            width: SpacingUnit.x25, height: SpacingUnit.x25, fit: BoxFit.fill),
      ],
    );
  }

  _setPosition(double value) {
    positions.add(value);
  }
}
