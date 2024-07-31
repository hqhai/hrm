import 'dart:async';
import 'dart:core';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/routers/query_params/shifts_query_params.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/data/models/request/work_day_request.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_event.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/item_day_of_list.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/item_day_of_week.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/week_on_calendar.dart';
import 'package:base_app/presentations/widgets/line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
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
  DateTime selectDate = DateTime.now();
  List<DateTime> listDateAppBar = [];
  double scrollOffset = 0.0;
  int indexLocal = 6;
  List<double> positions = [];
  late DateTime startOfWeek, endOfWeek;
  double positionEnd = 0;
  bool isShowCheckBox = false;
  Map<String, WorkDayRequest> workDays = {};

  //scroll
  int currentHeaderScrollIndex = 0;
  int currentBodyScrollIndex = 0;
  double currentHeaderScrollPosition = 0;
  bool isHeaderScroll = false;
  int currentIndexBody = 0;
//
  final ItemScrollController _scrollControllerHeader = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  ScrollOffsetListener scrollOffsetListener = ScrollOffsetListener.create();

  final ItemScrollController scrollControllerBody = ItemScrollController();
  final ScrollOffsetController scrollOffsetControllerBody =
      ScrollOffsetController();
  ItemPositionsListener itemPositionsListenerBody =
      ItemPositionsListener.create();
  ScrollOffsetListener scrollOffsetListenerBody = ScrollOffsetListener.create();

  @override
  void initState() {
    dI<WorkDayBloc>().add(ChangeSelectDate(date: DateTime.now()));
    _init();
    _headerScroll();
    _bodyScroll();
    _getData(DateTime.now());
    super.initState();
  }

  _getData(DateTime time) {
    final initData = listDays(time);
    dI<WorkDayBloc>().add(
        GetWorkDaysEvent(startDate: initData.first, endDate: initData.last));
  }

  _headerScroll() {
    itemPositionsListener.itemPositions.addListener(() async {
      Iterable<ItemPosition> listIndex =
          itemPositionsListener.itemPositions.value;
      int nextIndex = currentHeaderScrollIndex + 7;
      int previousIndex = currentHeaderScrollIndex - 7;
      if (currentHeaderScrollIndex < listIndex.first.index && !isHeaderScroll) {
        isHeaderScroll = true;
        _getData(listDateAppBar[nextIndex]);
        _scrollControllerHeader
            .scrollTo(
                index: nextIndex, duration: const Duration(milliseconds: 100))
            .whenComplete(() {
          scrollControllerBody.jumpTo(index: nextIndex);
          if ((listDateAppBar.length - 7) == nextIndex) {
            final listNextDate = _getNextDate(listDateAppBar.last);
            listDateAppBar = listNextDate;
          }
          isHeaderScroll = false;
          currentHeaderScrollIndex = nextIndex;
          currentDateTime = listDateAppBar[nextIndex];
        });
        currentDateTime = listDateAppBar[nextIndex];
      }
      if (currentHeaderScrollIndex > listIndex.first.index && !isHeaderScroll) {
        isHeaderScroll = true;
        _scrollControllerHeader
            .scrollTo(
                index: previousIndex,
                duration: const Duration(milliseconds: 100))
            .whenComplete(() {
          if (previousIndex == 0 && isHeaderScroll && previousIndex != 7) {
            final listPreviousDate = _getPreviousDate(listDateAppBar[0]);
            listDateAppBar = listPreviousDate;
            _scrollControllerHeader.jumpTo(index: 7);
            isHeaderScroll = false;
            currentHeaderScrollIndex = 7;
          } else {
            isHeaderScroll = false;
            currentHeaderScrollIndex = previousIndex;
            currentDateTime = listDateAppBar[0];
          }
        });
        _getData(listDateAppBar[0]);
      }
    });
  }

  _bodyScroll() {
    itemPositionsListenerBody.itemPositions.addListener(() async {
      Iterable<ItemPosition> listIndex =
          itemPositionsListenerBody.itemPositions.value;
      int nextIndex = currentHeaderScrollIndex + 7;
      int previousIndex = currentHeaderScrollIndex - 7;
      dI<WorkDayBloc>()
          .add(ChangeSelectDate(date: listDateAppBar[(listIndex.first.index)]));
      if (nextIndex <= listIndex.first.index && !isHeaderScroll) {
        isHeaderScroll = true;
        _scrollControllerHeader
            .scrollTo(
                index: nextIndex, duration: const Duration(milliseconds: 100))
            .whenComplete(() {
          if ((listDateAppBar.length - 7) == nextIndex) {
            final listNextDate = _getNextDate(listDateAppBar.last);
            listDateAppBar = listNextDate;
          }
          isHeaderScroll = false;
          currentHeaderScrollIndex = nextIndex;
        });
        _getData(listDateAppBar[nextIndex]);
      }

      if (currentHeaderScrollIndex > listIndex.first.index && !isHeaderScroll) {
        isHeaderScroll = true;
        _scrollControllerHeader
            .scrollTo(
                index: previousIndex,
                duration: const Duration(milliseconds: 100))
            .whenComplete(() {
          if (previousIndex == 0 && isHeaderScroll && previousIndex != 7) {
            final listPreviousDate = _getPreviousDate(listDateAppBar[0]);
            listDateAppBar = listPreviousDate;
            _scrollControllerHeader.jumpTo(index: 7);
            // scrollControllerBody.jumpTo(index: 7);
            scrollControllerBody.jumpTo(index: 7);
            isHeaderScroll = false;
            currentHeaderScrollIndex = 7;
          } else {
            isHeaderScroll = false;
            currentHeaderScrollIndex = previousIndex;
            currentDateTime = listDateAppBar[0];
          }
        });
        _getData(listDateAppBar[0]);
      }
    });
  }

  _init() {
    DateTime nowDate = DateTime.now();
    final dateLast = nowDate.subtract(const Duration(days: 7));
    final listDayLast = listDays(dateLast);
    final listMaxDate = listDays(nowDate);
    final dateNext = nowDate.add(const Duration(days: 7));
    final listDayNext = listDays(dateNext);
    listDateAppBar = [...listDayLast, ...listMaxDate, ...listDayNext];
  }

  List<DateTime> _getPreviousDate(DateTime date) {
    final dateLast = date.subtract(const Duration(days: 7));
    final listDayLast = listDays(dateLast);
    return [...listDayLast, ...listDateAppBar];
  }

  List<DateTime> _getNextDate(DateTime date) {
    final dateNext = date.add(const Duration(days: 7));
    final listDayNext = listDays(dateNext);
    return [...listDateAppBar, ...listDayNext];
  }

  List<DateTime> listDays(DateTime nowDate) {
    final int nowOfWeek =
        mapNumberDayInWeek[DateFormat('EEE').format(nowDate)] ?? 0;
    setState(() {
      startOfWeek = nowDate.subtract(Duration(days: nowOfWeek - 1));
      endOfWeek = startOfWeek.add(const Duration(days: 7));
    });
    List<DateTime> daysOfWeek = [];
    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      daysOfWeek.add(day);
    }
    return daysOfWeek;
  }

  _onBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return BlocConsumer<WorkDayBloc, WorkDayState>(
      listenWhen: (previous, current) =>
          previous.isLoading != current.isLoading,
      listener: (context, state) {
        if (state.isLoading) {
          _getData(listDateAppBar[currentHeaderScrollIndex]);
          dI<WorkDayBloc>().add(const ChangeLoading(status: false));
        }
      },
      builder: (context, state) {
        return BlocBuilder<WorkDayBloc, WorkDayState>(
          builder: (context, state) {
            return Scaffold(
              appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(SpacingUnit.x49),
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: SpacingUnit.x5,
                              right: SpacingUnit.x5,
                              bottom: SpacingUnit.x5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => _onBack(),
                                child: Icon(
                                  Icons.chevron_left,
                                  color: colors.text,
                                  size: SpacingUnit.x7,
                                ),
                              ),
                              Text(
                                appLocalizations.registerShift,
                                style: theme.textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.w600),
                              ),
                              const SizedBox()
                            ],
                          ),
                        ),
                        LineWidget(color: colors.outline),
                        WeekOnCalendar(
                          currentDateTime: state.selectDate ?? DateTime.now(),
                          downWeek: () => setDownWeek(),
                          upWeek: () => setUpWeek(),
                        ),
                        LineWidget(color: colors.outline),
                        const SizedBox(height: SpacingUnit.x1),
                        Expanded(
                          child: ScrollablePositionedList.builder(
                            initialAlignment: -1,
                            scrollDirection: Axis.horizontal,
                            itemCount: listDateAppBar.length,
                            itemScrollController: _scrollControllerHeader,
                            scrollOffsetController: scrollOffsetController,
                            itemPositionsListener: itemPositionsListener,
                            scrollOffsetListener: scrollOffsetListener,
                            itemBuilder: (context, index) {
                              final date = state.selectDate ?? DateTime.now();
                              return InkWell(
                                onTap: () => onChangeDateAppBar(index),
                                child: ItemDayOfWeek(
                                  index: index,
                                  time: listDateAppBar[index],
                                  select: date.day ==
                                          listDateAppBar[index].day &&
                                      date.month ==
                                          listDateAppBar[index].month &&
                                      date.year == listDateAppBar[index].year,
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: SpacingUnit.x1),
                        LineWidget(color: colors.outline),
                      ],
                    ),
                  )),
              body: Container(
                color: colors.surfaceVariantLow.withOpacity(0.1),
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                child: Stack(
                  children: [
                    ScrollablePositionedList.builder(
                      initialScrollIndex: _getCurrentIndex(),
                      itemCount: listDateAppBar.length,
                      itemScrollController: scrollControllerBody,
                      scrollOffsetController: scrollOffsetControllerBody,
                      itemPositionsListener: itemPositionsListenerBody,
                      scrollOffsetListener: scrollOffsetListenerBody,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => dI<AppNavigation>().push(context,
                              page: Pages.shiftsPage,
                              paramsQuerry:
                                  ShiftsQueryParams(date: listDateAppBar[index])
                                      .toJson()),
                          child: ItemDayOfList(
                            selected:
                                workDays[listDateAppBar[index].toString()] !=
                                    null,
                            isCheckBox: isShowCheckBox,
                            dateTime: listDateAppBar[index],
                            onChange: (WorkDayRequest value) =>
                                _addItemRegister(value),
                          ),
                        );
                      },
                    ),
                    if (isShowCheckBox)
                      Positioned(
                        right: SpacingUnit.x4,
                        bottom: SpacingUnit.x8,
                        child: InkWell(
                          onTap: () => _register(),
                          child: Container(
                              padding:
                                  const EdgeInsets.only(left: SpacingUnit.x5),
                              alignment: Alignment.centerLeft,
                              width: SpacingUnit.x40,
                              height: SpacingUnit.x10,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x13),
                                color: colors.primary.withOpacity(0.7),
                              ),
                              child: Text(
                                "Đăng ký ca",
                                style: theme.textTheme.bodyLarge!.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600),
                              )),
                        ),
                      ),
                    Positioned(
                      right: SpacingUnit.x4,
                      bottom: SpacingUnit.x8,
                      child: InkWell(
                        onTap: () => _register(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(SpacingUnit.x13),
                            color: colors.primary,
                            border: Border.all(color: colors.blue, width: 1),
                          ),
                          child: Icon(
                            isShowCheckBox ? Icons.check : Icons.add,
                            color: Colors.white,
                            size: SpacingUnit.x10,
                          ),
                        ),
                      ),
                    ),
                    if (isShowCheckBox)
                      Positioned(
                        left: SpacingUnit.x4,
                        bottom: SpacingUnit.x8,
                        child: InkWell(
                          onTap: () => _closeRegister(),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(SpacingUnit.x13),
                              color: colors.error,
                            ),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white,
                              size: SpacingUnit.x10,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _addItemRegister(WorkDayRequest workDayRequest) {
    if (workDays[workDayRequest.workDate] == null) {
      setState(() {
        workDays = {...workDays, workDayRequest.workDate: workDayRequest};
      });
    } else {
      setState(() {
        workDays.remove(workDayRequest.workDate);
      });
    }
  }

  _register() {
    if (isShowCheckBox) {
      setState(() {
        dI<WorkDayBloc>().add(RegisterWorkDay(data: workDays));
        isShowCheckBox = false;
        dI<WorkDayBloc>().add(const ChangeLoading(status: true));
        workDays.clear();
      });
    } else {
      setState(() {
        isShowCheckBox = !isShowCheckBox;
      });
    }
  }

  _closeRegister() {
    setState(() {
      workDays.clear();
      isShowCheckBox = !isShowCheckBox;
    });
  }

  int _getCurrentIndex() {
    DateTime date = DateTime.now();
    int index = listDateAppBar.indexWhere((element) =>
        date.day == element.day &&
        date.month == element.month &&
        date.year == element.year);
    return index;
  }

  setDownWeek({Completer? completer}) {
    setState(() {
      int previousIndex = currentHeaderScrollIndex - 7;
      isHeaderScroll = true;
      _scrollControllerHeader
          .scrollTo(
              index: previousIndex, duration: const Duration(milliseconds: 100))
          .whenComplete(() {
        if (previousIndex == 0 && isHeaderScroll && previousIndex != 7) {
          final listPreviousDate = _getPreviousDate(listDateAppBar[0]);
          listDateAppBar = listPreviousDate;
          _scrollControllerHeader.jumpTo(index: 7);
          isHeaderScroll = false;
          currentHeaderScrollIndex = 7;
        } else {
          isHeaderScroll = false;
          currentHeaderScrollIndex = previousIndex;
          currentDateTime = listDateAppBar[0];
        }
      });
      _getData(listDateAppBar[0]);
      currentDateTime = listDateAppBar[previousIndex];
    });
  }

  setUpWeek({Completer? completer}) {
    setState(() {
      itemPositionsListener.itemPositions.value;
      int nextIndex = currentHeaderScrollIndex + 7;
      scrollControllerBody.jumpTo(index: nextIndex);
      _scrollControllerHeader
          .scrollTo(
              index: nextIndex, duration: const Duration(milliseconds: 300))
          .whenComplete(() {
        if ((listDateAppBar.length - 7) == nextIndex) {
          final listNextDate = _getNextDate(listDateAppBar.last);
          listDateAppBar = listNextDate;
        }
        currentHeaderScrollIndex = nextIndex;
        currentDateTime = listDateAppBar[nextIndex];
        if (completer != null) {
          completer.complete(true);
        }
      });
      currentHeaderScrollIndex = nextIndex;
      currentDateTime = listDateAppBar[nextIndex];
      _getData(listDateAppBar[nextIndex]);
    });
  }

  onChangeDateAppBar(int index) {
    dI<WorkDayBloc>().add(ChangeSelectDate(date: listDateAppBar[index]));
    scrollControllerBody.jumpTo(index: index);
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
}
