import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/notes/notes_bloc.dart';
import 'package:base_app/presentations/bloc/notes/notes_event.dart';
import 'package:base_app/presentations/bloc/notes/notes_state.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_dialog_common.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/success_or_unsuccess_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

class CreateNoteWidget extends StatefulWidget {
  const CreateNoteWidget({
    super.key,
  });

  @override
  State<CreateNoteWidget> createState() => _CreateNoteWidgetState();
}

class _CreateNoteWidgetState extends State<CreateNoteWidget> {
  final TextEditingController contentController = TextEditingController();
  late String dateNote, checkContent, error;

  @override
  void initState() {
    super.initState();
    checkContent = '';
    dateNote = formatYMD(DateTime.now().toString());
    contentController.text = '';
    error = '';
  }

  @override
  void dispose() {
    super.dispose();
    contentController.dispose();
  }

  _listener(BuildContext context, NotesState state) {
    final appLocalizations = AppLocalizations.of(context)!;
    setState(() {
      if (state.status == NoteStatus.createNoteSuccess) {
        successDialog(context);
        error = '';
      } else if (state.status == NoteStatus.createNoteError) {
        unsuccessfulDialog(context);
        error = '';
      } else if (state.status == NoteStatus.createNoteErrorAlreadyExistOnDay) {
        successFullDialog(context, "${appLocalizations.youMadeANoteOnTheDate} $dateNote");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocListener<NotesBloc, NotesState>(
      listener: (context, state) => _listener(context, state),
      listenWhen: (previous, current) => previous.status != current.status,
      child: Container(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    appLocalizations.dateNote,
                    style: TextStyle(fontSize: SpacingUnit.x4_5, color: colors.text),
                  ),
                  const SizedBox(width: SpacingUnit.x3_5),
                  DatePicker(
                    onChange: (value) => dateNote = formatYMD(value.toString()),
                  )
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
                    onPressed: () => _createNote(context, contentController.text, dateNote),
                    child: Text(appLocalizations.create,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5)),
                  ),
                  const SizedBox(width: SpacingUnit.x5),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _createNote(BuildContext context, String note, String dateTime) {
    final appLocalizations = AppLocalizations.of(context)!;
    DateTime now = DateTime.now();
    if (checkContent != '') {
      if (DateFormat('yyyy-MM-dd')
          .parse(dateNote)
          .isBefore(DateTime(now.year, now.month, now.day))) {
        setState(() {
          error = appLocalizations.theNoteDateCannotBeBeforeThePresentTime;
        });
      } else {
        dI<NotesBloc>().add(CreateNotesEvent(note: note, dateTime: dateTime));
      }
    } else {
      setState(() {
        error = appLocalizations.theContentAndTitleCannotBeLeftBlank;
      });
    }
  }
}
