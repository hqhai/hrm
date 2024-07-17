import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class NoteDialog extends StatefulWidget {
  final ValueChanged<String> noteChange;
  final VoidCallback callback;
  final EnumStepRequestStatusEnum? status;

  const NoteDialog({super.key, required this.noteChange, required this.callback, this.status});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController noteController = TextEditingController();
  String errorNote = '';

  bool checkNote(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final check = (widget.status == EnumStepRequestStatusEnum.reject ||
            widget.status == EnumStepRequestStatusEnum.edit) &&
        noteController.text == '';
    setState(() {
      errorNote = !check ? "" : appLocalizations.cannotBeLeftBlank;
    });
    return !check;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4_5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(appLocalizations.note),
          const SizedBox(
            height: SpacingUnit.x4_5,
          ),
          AppInputArea(
            minLines: 5,
            maxLines: 5,
            placeHolder: appLocalizations.note,
            controller: noteController,
            onChange: (value) => widget.noteChange.call(value),
          ),
          if (errorNote.isNotEmpty)
            Text(errorNote,
                style: TextStyle(
                  fontSize: SpacingUnit.x3,
                  color: colors.error,
                )),
          const SizedBox(
            height: SpacingUnit.x4_5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _setCall(context),
                child: Text(appLocalizations.ok),
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
    );
  }

  _setCall(BuildContext context) {
    if (checkNote(context)) {
      widget.callback.call();
      Navigator.of(context).pop();
    }
  }
}
