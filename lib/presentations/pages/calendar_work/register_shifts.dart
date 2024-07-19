import 'dart:core';

import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/calendar_work/item_day_of_list.dart';
import 'package:base_app/presentations/pages/calendar_work/item_day_of_week.dart';
import 'package:base_app/presentations/pages/calendar_work/week_on_calendar.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
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
  late RefreshController _refreshController;
  late ItemScrollController itemScrollController;
  double scrollOffset = 0.0;
  int indexLocal = 6;

  @override
  void initState() {
    listDayBottom = [...listDays()];
    itemScrollController = ItemScrollController();
    _refreshController = RefreshController(initialRefresh: false);
    super.initState();
  }

  List<DateTime> listDays() {
    int nowOfWeek = mapNumberDayInWeek[DateFormat('EEE').format(currentDateTime)] ?? 0;
    DateTime startOfWeek = currentDateTime.subtract(Duration(days: nowOfWeek - 1));
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
                        onTap: () => onClickDay(element),
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
              child: SmartRefresher(
                cacheExtent: 0,
                header: CustomHeader(
                  builder: (context, mode) => Container(),
                ),
                footer: CustomFooter(
                  builder: (context, mode) => Container(),
                ),
                enablePullDown: true,
                enablePullUp: true,
                controller: _refreshController,
                onLoading: _onLoading,
                onRefresh: _onRefresh,
                child: ScrollablePositionedList.builder(
                  itemScrollController: itemScrollController,
                  itemCount: listDayBottom.length,
                  itemBuilder: (context, index) => ItemDayOfList(
                    dateTime: listDayBottom[index],
                  ),
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
    _refreshController.dispose();
    super.dispose();
  }

  setDownWeek() {
    setState(() {
      currentDateTime = currentDateTime.subtract(const Duration(days: 7));
      listDayBottom = [...listDays(), ...listDayBottom];
    });
  }

  setUpWeek() {
    setState(() {
      currentDateTime = currentDateTime.add(const Duration(days: 7));
      listDayBottom = [...listDayBottom, ...listDays()];
    });
  }

  void _onRefresh() async {
    setDownWeek();
    _refreshController.refreshCompleted();
    itemScrollController.jumpTo(index: 7);
  }

  void _onLoading() async {
    setUpWeek();
    _refreshController.loadComplete();
  }

  void _scrollToPosition() {}

  onClickDay(DateTime date) {
    final index = listDayBottom.indexWhere((element) => element.isAtSameMomentAs(date));
    itemScrollController.scrollTo(
      index: index,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOutCubic,
    );
  }
}
