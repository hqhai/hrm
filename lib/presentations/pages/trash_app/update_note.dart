import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/dialog/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final updateNotePageRoute = GoRoute(
    name: Pages.updateNotesPage,
    path: Pages.updateNotesPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return UpdateNoteWidget(
        id: data['id'],
      );
    });

class UpdateNoteWidget extends StatefulWidget {
  const UpdateNoteWidget({super.key, required this.id});

  final String id;

  @override
  State<UpdateNoteWidget> createState() => _UpdateNoteWidgetState();
}

class _UpdateNoteWidgetState extends State<UpdateNoteWidget> {
  late TextEditingController contentController;
  late String dateNote, checkContent, error;

  @override
  void initState() {
    super.initState();
    contentController = TextEditingController();
    dI<NotesBloc>().add(GetNoteByIdEvent(id: widget.id));
    dateNote = formatYMD(DateTime.now().toString());
    error = '';
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  _listener(BuildContext context, NotesState state) {
    if (state.status == NoteStatus.getNoteSuccess) {
      setState(() {
        dateNote = formatYMD(state.note.dateTime);
        checkContent = state.note.note;
        contentController.text = state.note.note;
      });
    }
    if (state.status == NoteStatus.updateNoteSuccess) {
      dI<NotesBloc>().add(GetNoteByIdEvent(id: widget.id));
      //Navigator.of(context).pop();
      successDialog(context);
    } else if (state.status == NoteStatus.updateNoteError) {
      unsuccessfulDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<NotesBloc, NotesState>(
        listener: (context, state) => _listener(context, state),
        listenWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) => Container(
          margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
          height: MediaQuery.sizeOf(context).height,
          decoration: BoxDecoration(
            color: CustomsColor.colorBackground,
            borderRadius: const BorderRadius.all(
              Radius.circular(SpacingUnit.x4),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: SpacingUnit.x4_5),
                Row(
                  children: [
                    Text(
                      '${appLocalizations.dateNote} : ',
                      style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                    ),
                    const SizedBox(width: SpacingUnit.x3_5),
                    Text(
                      formatYMD(state.note.dateTime),
                      style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                    ),
                  ],
                ),
                const SizedBox(height: SpacingUnit.x6_5),
                Text(
                  appLocalizations.note,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4_5),
                ),
                const SizedBox(height: SpacingUnit.x4_5),
                AppInputArea(
                  minLines: 10,
                  maxLines: 10,
                  placeHolder: appLocalizations.content,
                  controller: contentController,
                  onChange: (value) => setState(() => checkContent = value),
                ),
                const SizedBox(height: SpacingUnit.x4_5),
                if (error != '')
                  Text(
                    error,
                    style: TextStyle(color: colors.error, fontSize: SpacingUnit.x4_5),
                  ),
                if (error != '') const SizedBox(height: SpacingUnit.x4_5),
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: colors.blue),
                      onPressed: () => _updateNote(
                          context, contentController.text, state.note.id, state.note.dateTime),
                      child: Text(appLocalizations.update,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                    ),
                    const SizedBox(width: SpacingUnit.x5),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool _checkTextField() {
    return checkContent != '';
  }

  _updateNote(BuildContext context, String note, String id, String dateTime) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (_checkTextField()) {
      dI<NotesBloc>().add(UpdateNotesEvent(id: id, note: note, dateTime: dateTime));
    } else {
      setState(() {
        error = appLocalizations.theContentAndTitleCannotBeLeftBlank;
      });
    }
  }
}
