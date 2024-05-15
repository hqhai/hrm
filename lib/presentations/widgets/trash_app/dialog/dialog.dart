
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/note.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:flutter/material.dart';


noteDialog(BuildContext context, Note note) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          height: SpacingUnit.x75,
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(appLocalizations.createTime,
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                Text(note.dateTime,
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                const SizedBox(
                  height: SpacingUnit.x4_5,
                ),
                Text(appLocalizations.note,
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                Text(note.note,
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                const SizedBox(
                  height: SpacingUnit.x4_5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            dI<AppNavigation>().pushName(context, page: Pages.updateNotesPage, extra: {'id': note.id});
                            Navigator.of(context).pop();
                          },
                          child: Text(appLocalizations.update),
                        ),
                        ElevatedButton(
                          child: Text(appLocalizations.delete),
                          onPressed: () {
                            Navigator.of(context).pop();
                            deleteNoteDialog(context, note);
                          },
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text(appLocalizations.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

deleteNoteDialog(BuildContext context, Note note) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          height: SpacingUnit.x20,
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations.doYouWantToDeleteTheNote,
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text(appLocalizations.ok),
                      onPressed: () {
                        dI<NotesBloc>().add(DeleteNoteEvent(id: note.id));
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text(appLocalizations.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}

deleteAccountDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          height: SpacingUnit.x20,
          child: SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(appLocalizations.doYouWantToDeleteYourAccount,
                    textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text(appLocalizations.ok),
                      onPressed: () {
                        dI<UserBloc>().add(const DeleteAccountEvent());
                        Navigator.of(context).pop();
                      },
                    ),
                    ElevatedButton(
                      child: Text(appLocalizations.cancel),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    },
  );
}



