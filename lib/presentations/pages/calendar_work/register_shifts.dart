import 'dart:async';
import 'dart:core';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/ahift/shift_bloc.dart';
import 'package:base_app/presentations/bloc/ahift/shift_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/item_day_of_list.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/item_day_of_week.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/week_on_calendar.dart';
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
  late DateTime startOfWeek, endOfWeek;
  double positionEnd = 0;

  @override
  void initState() {
    listDayBottom = [...listDays()];
    dI<WorkDayBloc>().add(GetWorkDaysEvent(startDate: startOfWeek, endDate: endOfWeek));
    _scrollController = ScrollController();
    super.initState();
  }

  List<DateTime> listDays() {
    final int nowOfWeek = mapNumberDayInWeek[DateFormat('EEE').format(currentDateTime)] ?? 0;
    setState(() {
      startOfWeek = currentDateTime.subtract(Duration(days: nowOfWeek - 1));
      endOfWeek = startOfWeek.add(const Duration(days: 7));
    });
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
    //final width = MediaQuery.of(context).size.width;
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
      body: Stack(
        children: [
          ContainerScreenMain(
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
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Column(
                      children: listDayBottom
                          .map(
                            (e) => ItemDayOfList(
                              dateTime: e,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: SpacingUnit.x3,
            bottom: SpacingUnit.x6,
            child: InkWell(
              onTap: () => addShift(),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpacingUnit.x13),
                  color: colors.blue,
                  border: Border.all(color: colors.blue, width: 1),
                ),
                child: Icon(
                  Icons.add,
                  color: colors.text,
                  size: SpacingUnit.x10,
                ),
              ),
            ),
          ),
        ],
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
      listDayBottom = [
        ...listDays(),
      ];
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
      duration: const Duration(
        milliseconds: 300,
      ),
      curve: Curves.linear,
    );
  }

  Widget loadDing() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Lottie.asset(Assets.images.icon.loading,
            width: SpacingUnit.x25, height: SpacingUnit.x25, fit: BoxFit.fill),
      ],
    );
  }

  _nextShiftsScreen({required String id}) async {
    final Completer completer = Completer<bool>();
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<ShiftBloc>().add(
      GetShiftByIdEvent(id: id, completer: completer),
    );
    final statusCompleter = await completer.future;
    if (statusCompleter == true) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pushName(
        currentContext,
        page: Pages.shiftsPage,
        extra: {
          'id': id,
        },
      );
    }
  }

  addShift() {}

/*_setPositionEnd({required DragStartDetails details}) {
    setState(() {
      positionEnd = details.localPosition.dx;
    });
  }*/
}
