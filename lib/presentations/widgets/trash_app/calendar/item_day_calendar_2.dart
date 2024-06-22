import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/widgets/trash_app/dialog/dialog.dart';
import 'package:common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class BodyCalendar2 extends StatefulWidget {
  final int month;
  final int year;
  final Map<int, String> mapMonth;
  final Map<String, String> mapDayInWeek;
  final Map<String, int> mapNumberDayInWeek;
  final List<DateTime> listDate;
  final List<DateTime>? listItemDate;
  final Map<DateTime, Widget>? widget;

  const BodyCalendar2(
      {super.key,
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
      _selectedIndex * width * 1,
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
              height: height * 0.77,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.listDate.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        if (_checkNote(state.notes, widget.listDate[index], widget.month) != -1) {
                          noteDialog(
                              context,
                              state.notes[
                                  _checkNote(state.notes, widget.listDate[index], widget.month)]);
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
    return _Item(
      date: widget.listDate[index],
      month: widget.month,
      noteIndex: _checkNote(state.notes, widget.listDate[index], widget.month),
      note: _checkNote(state.notes, widget.listDate[index], widget.month) != -1
          ? state.notes[_checkNote(state.notes, widget.listDate[index], widget.month)]
          : const Note(
              id: '',
              dateTime: '',
              note: '',
              createdUserId: '',
              createdDate: '',
              createdFullName: ''),
      itemDate: _getWidgetContent(widget.listDate[index]),
      isNowDate: _checkDateNow(widget.listDate[index]),
    );
  }
}

class _Item extends StatelessWidget {
  final bool isNowDate;
  final Note note;
  final int month;
  final int noteIndex;
  final DateTime date;
  final Widget itemDate;

  const _Item({
    required this.note,
    required this.noteIndex,
    required this.date,
    required this.month,
    required this.itemDate,
    required this.isNowDate,
  });

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;
    return Container(
      width: width - SpacingUnit.x10,
      margin: const EdgeInsets.all(SpacingUnit.x5),
      padding: const EdgeInsets.all(SpacingUnit.x5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SpacingUnit.x2),
        color: colors.surfaceDim,
        border: Border.all(
          color: colors.surfaceBright,
          width: 1,
        ),
      ),
      alignment: Alignment.topRight,
      child: Column(
        children: [
          Expanded(
            flex: 20,
            child: Align(
              alignment: Alignment.topCenter,
              child: CircleAvatar(
                backgroundColor: isNowDate ? colors.primary : Colors.transparent,
                child: Text(
                  date.day.toString(),
                  style: theme.textTheme.titleLarge!.copyWith(color: colors.text),
                ),
              ),
            ),
          ),
          if (note.note != '')
            Expanded(
              flex: 10,
              child: Text(
                appLocalizations.note,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x6),
              ),
            ),
          Expanded(
            flex: note.note != '' ? 70 : 80,
            child: Text(
              note.note,
              maxLines: 15,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
            ),
          ),
        ],
      ),
    );
  }
}
