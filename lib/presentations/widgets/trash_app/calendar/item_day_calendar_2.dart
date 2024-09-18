import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/widgets/trash_app/calendar/item_calender_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyCalendar2 extends StatefulWidget {
  final int month;
  final int year;
  final Map<int, String> mapMonth;
  final Map<String, String> mapDayInWeek;
  final Map<String, int> mapNumberDayInWeek;
  final List<DateTime> listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? widget;
  final bool checkTypeCalender;

  const BodyCalendar2(
      {super.key,
      required this.checkTypeCalender,
      required this.month,
      required this.year,
      required this.mapMonth,
      required this.mapDayInWeek,
      required this.mapNumberDayInWeek,
      required this.listDate,
      this.widget,
      this.listItemDate});

  @override
  State<BodyCalendar2> createState() => _BodyCalendar2State();
}

class _BodyCalendar2State extends State<BodyCalendar2> {
  late String token;
  int checkIn = 3;
  final ScrollController _scrollController = ScrollController();
  late int _selectedIndex;

  Widget _getWidgetContent(DateTime date) {
    if (widget.widget == null) return const SizedBox();
    return widget.widget?[date] ?? Container();
  }

  bool _checkDateNow(DateTime date) {
    DateTime dateTime = DateTime.now();
    if (dateTime.day == date.day && dateTime.month == date.month && dateTime.year == date.year) {
      return true;
    }
    return false;
  }

  int _checkNote(List<Note> notes, DateTime date, int month) {
    List<String> noteDates = notes.map((e) => e.dateTime.toString()).toList();
    int index = noteDates.indexWhere((e) {
      DateTime dateTime = DateTime.parse(e);
      return dateTime.month == month && dateTime.day == date.day && month == date.month;
    });
    return index != -1 ? index : -1;
  }

  @override
  void initState() {
    _selectedIndex = DateTime.now().day - 1;
    dI<NotesBloc>().add(GetNotesEvent(
        startDate: formatYMD(DateTime(widget.year, widget.month, 1).toString()),
        endDate: formatYMD(DateTime(widget.year, widget.month + 1, 0).toString())));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedIndex();
    });
    super.initState();
  }

  _listener(BuildContext context, NotesState state) {
    if (state.status == NoteStatus.updateNoteSuccess) {
      dI<NotesBloc>().add(GetNotesEvent(
          startDate: formatYMD(DateTime(widget.year, widget.month, 1).toString()),
          endDate: formatYMD(DateTime(widget.year, widget.month + 1, 0).toString())));
    } else if (state.status == NoteStatus.deleteNoteSuccess) {
      dI<NotesBloc>().add(GetNotesEvent(
          startDate: formatYMD(DateTime(widget.year, widget.month, 1).toString()),
          endDate: formatYMD(DateTime(widget.year, widget.month + 1, 0).toString())));
    }
  }

  void _scrollToSelectedIndex() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    if (!currentContext.mounted) return;
    final width = MediaQuery.sizeOf(currentContext).width;
    _scrollController.animateTo(
      _selectedIndex * (widget.checkTypeCalender ? width : width * 0.3 + SpacingUnit.x3),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    return BlocConsumer<NotesBloc, NotesState>(
      listener: (context, state) => _listener(context, state),
      builder: (context, state) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 3),
              width: width,
              height: height * 0.7,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.listDate.length,
                scrollDirection: widget.checkTypeCalender ? Axis.horizontal : Axis.vertical,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        if (_checkNote(state.notes, widget.listDate[index], widget.month) != -1) {
                          dI<AppNavigation>().pushName(context, page: Pages.noteSystem, extra: {
                            'note': state.notes[
                                _checkNote(state.notes, widget.listDate[index], widget.month)],
                          });
                        }
                      },
                      child: _item(index, state));
                },
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
          ],
        );
      },
    );
  }

  Widget _item(int index, NotesState state) {
    return widget.checkTypeCalender
        ? ItemHorizontal(
            date: widget.listDate[index],
            month: widget.month,
            noteIndex: _checkNote(state.notes, widget.listDate[index], widget.month),
            note: _checkNote(state.notes, widget.listDate[index], widget.month) != -1
                ? state.notes[_checkNote(state.notes, widget.listDate[index], widget.month)]
                : Note(
                    id: '',
                    dateTime: DateTime.now(),
                    note: '',
                    createdUserId: '',
                    createdDate: '',
                    createdFullName: ''),
            itemDate: _getWidgetContent(widget.listDate[index]),
            isNowDate: _checkDateNow(widget.listDate[index]),
          )
        : ItemVertical(
            date: widget.listDate[index],
            month: widget.month,
            noteIndex: _checkNote(state.notes, widget.listDate[index], widget.month),
            note: _checkNote(state.notes, widget.listDate[index], widget.month) != -1
                ? state.notes[_checkNote(state.notes, widget.listDate[index], widget.month)]
                : Note(
                    id: '',
                    dateTime: DateTime.now(),
                    note: '',
                    createdUserId: '',
                    createdDate: '',
                    createdFullName: ''),
            itemDate: _getWidgetContent(widget.listDate[index]),
            isNowDate: _checkDateNow(widget.listDate[index]),
          );
  }
}
