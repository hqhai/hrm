import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/presentations/bloc/auth/auth_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/bloc/notes/notes_system_cubit.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/item_day_of_week.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/week_on_calendar.dart';
import 'package:base_app/presentations/widgets/line.dart';
import 'package:base_app/presentations/widgets/trash_app/calendar/item_note_system_day_of_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:themes/themes.dart';

class NotesSystemList extends StatefulWidget {
  const NotesSystemList({super.key});

  @override
  State<NotesSystemList> createState() => _NotesSystemListState();
}

class _NotesSystemListState extends State<NotesSystemList> {
  List<DateTime> listDateAppBar = [];
  late DateTime startOfWeek, endOfWeek;
  bool isShowCheckBox = false;
  List<Note> notes = [];
  bool isEnable = false;

  int currentHeaderScrollIndex = 0;
  bool isHeaderScroll = false;
  bool isScroll = false;

  final ItemScrollController _scrollControllerHeader = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  final ItemScrollController scrollControllerBody = ItemScrollController();
  final ItemPositionsListener itemPositionsListenerBody =
      ItemPositionsListener.create();

  @override
  void initState() {
    dI<NoteSystemCubit>().changeSelectDate(selectDate: DateTime.now());
    _init();
    _bodyScroll();
    _getData();
    super.initState();
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

  _bodyScroll() {
    itemPositionsListenerBody.itemPositions.addListener(() async {
      Iterable<ItemPosition> listIndex =
          itemPositionsListenerBody.itemPositions.value;
      int nextIndex = currentHeaderScrollIndex + 7;
      dI<NoteSystemCubit>().changeSelectDate(
          selectDate: listDateAppBar[(listIndex.first.index)]);
      if (nextIndex <= listIndex.first.index && !isHeaderScroll) {
        setUpWeek();
      } else if (currentHeaderScrollIndex > listIndex.first.index &&
          !isHeaderScroll) {
        setDownWeek();
      }
    });
  }

  setDownWeek({Completer? completer, bool isFistIndex = false}) {
    int previousIndex = currentHeaderScrollIndex - 7;
    isHeaderScroll = true;
    _scrollControllerHeader
        .scrollTo(
            index: previousIndex, duration: const Duration(milliseconds: 10))
        .whenComplete(() {
      // final index = isFistIndex ? 7 : 13;
      scrollControllerBody.jumpTo(index: previousIndex);
      if (previousIndex == 0 && isHeaderScroll && previousIndex != 7) {
        final listPreviousDate = _getPreviousDate(listDateAppBar[0]);
        listDateAppBar = listPreviousDate;
        _scrollControllerHeader.jumpTo(index: 7);
        scrollControllerBody.jumpTo(index: 7);
        isHeaderScroll = false;
        currentHeaderScrollIndex = 7;
        onChangeDateAppBar(7);
      } else {
        isHeaderScroll = false;
        currentHeaderScrollIndex = previousIndex;
        onChangeDateAppBar(previousIndex);
      }
      setState(() {
        isScroll = true;
      });
    });
    _getData();
  }

  _getData() {
    if (dI<AuthBloc>().state.status != AuthStatus.ignoreLogin) {
      dI<NoteSystemCubit>().getNotesEvent(
          startDate: listDateAppBar.first, endDate: listDateAppBar.last);
    }
  }

  List<DateTime> _getNextDate(DateTime date) {
    final dateNext = date.add(const Duration(days: 7));
    final listDayNext = listDays(dateNext);
    return [...listDateAppBar, ...listDayNext];
  }

  List<DateTime> _getPreviousDate(DateTime date) {
    final dateLast = date.subtract(const Duration(days: 7));
    final listDayLast = listDays(dateLast);
    return [...listDayLast, ...listDateAppBar];
  }

  setUpWeek({Completer? completer}) {
    int nextIndex = currentHeaderScrollIndex + 7;
    isHeaderScroll = true;
    _scrollControllerHeader
        .scrollTo(index: nextIndex, duration: const Duration(milliseconds: 10))
        .whenComplete(() {
      scrollControllerBody.jumpTo(index: nextIndex);
      if ((listDateAppBar.length - 7) == nextIndex) {
        final listNextDate = _getNextDate(listDateAppBar.last);
        listDateAppBar = listNextDate;
      }
      isHeaderScroll = false;
      currentHeaderScrollIndex = nextIndex;
      if (isEnable) {
        onChangeDateAppBar(nextIndex);
      }
      setState(() {
        isScroll = true;
      });
    });
    _getData();
  }

  _scrollDownWeek() async {
    if (currentHeaderScrollIndex != 0) {
      setState(() {
        isScroll = true;
      });
      await setDownWeek(isFistIndex: true);
    }
  }

  _scrollUpWeek() async {
    setState(() {
      isScroll = true;
    });
    await setUpWeek();
  }

  int _getCurrentIndex() {
    DateTime date = DateTime.now();
    int index = listDateAppBar.indexWhere((element) =>
        date.day == element.day &&
        date.month == element.month &&
        date.year == element.year);
    return index;
  }

  onChangeDateAppBar(int index) {
    dI<NoteSystemCubit>().changeSelectDate(selectDate: listDateAppBar[index]);
    scrollControllerBody.jumpTo(index: index);
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return BlocBuilder<NoteSystemCubit, NotesState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(SpacingUnit.x49),
              child: SizedBox(
                height: SpacingUnit.x34,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    WeekOnCalendar(
                      currentDateTime: state.selectDay ?? DateTime.now(),
                      downWeek: () => _scrollDownWeek(),
                      upWeek: () => _scrollUpWeek(),
                    ),
                    LineWidget(color: colors.outline),
                    const SizedBox(height: SpacingUnit.x1),
                    Expanded(
                      child: ScrollablePositionedList.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        initialAlignment: -1,
                        scrollDirection: Axis.horizontal,
                        itemCount: listDateAppBar.length,
                        itemScrollController: _scrollControllerHeader,
                        scrollOffsetController: scrollOffsetController,
                        itemPositionsListener: itemPositionsListener,
                        scrollOffsetListener: scrollOffsetListener,
                        itemBuilder: (context, index) {
                          final date = state.selectDay ?? DateTime.now();
                          return InkWell(
                            onTap: () => onChangeDateAppBar(index),
                            child: ItemDayOfWeek(
                              index: index,
                              time: listDateAppBar[index],
                              select: date.day == listDateAppBar[index].day &&
                                  date.month == listDateAppBar[index].month &&
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
            child: ScrollablePositionedList.builder(
              initialScrollIndex: _getCurrentIndex(),
              itemCount: listDateAppBar.length,
              itemScrollController: scrollControllerBody,
              itemPositionsListener: itemPositionsListenerBody,
              itemBuilder: (context, index) {
                return ItemNoteSystemDayOfList(
                  dateTime: listDateAppBar[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
