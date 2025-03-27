import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/bloc/notes/notes_system_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemNoteSystemDayOfList extends StatefulWidget {
  final DateTime dateTime;

  const ItemNoteSystemDayOfList({
    super.key,
    required this.dateTime,
  });

  @override
  State<ItemNoteSystemDayOfList> createState() =>
      _ItemNoteSystemDayOfListState();
}

class _ItemNoteSystemDayOfListState extends State<ItemNoteSystemDayOfList> {
  double heightWidget = 0;
  bool isSelect = false;

  @override
  void initState() {
    super.initState();
  }

  DateTime date(DateTime time) {
    final dateType = DateTime(time.year, time.month, time.day);
    return dateType;
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Note> getNote(List<Note> listNotes) {
    final List<Note> list = listNotes
        .where((element) =>
            date(element.dateTime ?? DateTime.now()) == date(widget.dateTime))
        .toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    final theme = Theme.of(context);
    return BlocBuilder<NoteSystemCubit, NotesState>(
      builder: (context, state) {
        final notes = getNote(state.notes);
        return Column(
          crossAxisAlignment: notes.isNotEmpty
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: width,
              child: Padding(
                padding: const EdgeInsets.all(SpacingUnit.x4),
                child: Text(
                  '${nameWeekDay(widget.dateTime)}, ${dayMonthYear(
                    time: widget.dateTime,
                    context: context,
                  )}',
                  style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3_5,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            notes.isNotEmpty
                ? Container(
                    width: MediaQuery.sizeOf(context).width,
                    color: colors.background,
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...notes.map((e) {
                          return InkWell(
                            onTap: () {
                              if (notes.isNotEmpty) {
                                dI<AppNavigation>().pushName(context,
                                    page: Pages.noteSystem,
                                    extra: {
                                      'note': e,
                                    });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: SpacingUnit.x4,
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: SpacingUnit.x1),
                              alignment: Alignment.centerLeft,
                              width: MediaQuery.sizeOf(context).width,
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(SpacingUnit.x2),
                                color: colors.text.withValues(alpha: 0.2),
                              ),
                              height: SpacingUnit.x12,
                              child: Text(
                                e.note,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                : Container(
                    width: MediaQuery.sizeOf(context).width,
                    color: colors.background,
                    padding: const EdgeInsets.all(SpacingUnit.x7),
                    child: Center(
                      child: Text(
                        'Không có ghi chú',
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x3_5,
                        ),
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
