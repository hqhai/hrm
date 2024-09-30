import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
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
            onTap: () => onTap(),
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
              Expanded(
                child: AppButton(
                  marginRight: SpacingUnit.x2,
                  color: colors.background,
                  colorBorder: colors.blue,
                  colorText: colors.blue,
                  title: appLocalizations.cancel,
                  onSubmit: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: AppButton(
                  marginLeft: SpacingUnit.x2,
                  colorBorder: colors.blue,
                  color: colors.blue,
                  onSubmit: () => _setCall(context),
                  title: appLocalizations.ok,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _setCall(BuildContext context) {
    if (checkNote(context)) {
      Navigator.of(context).pop();
      widget.callback.call();
    }
  }

  onTap() {}
}

class NoteCancelRequestDialog extends StatefulWidget {
  final ValueChanged<String> noteChange;
  final VoidCallback callback;

  const NoteCancelRequestDialog({super.key, required this.noteChange, required this.callback});

  @override
  State<NoteCancelRequestDialog> createState() => _NoteCancelRequestDialogState();
}

class _NoteCancelRequestDialogState extends State<NoteCancelRequestDialog> {
  final TextEditingController noteController = TextEditingController();
  String errorNote = '';

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
            error: noteController.text == '' ? appLocalizations.cannotBeLeftBlank : '',
            minLines: 5,
            maxLines: 5,
            placeHolder: appLocalizations.note,
            controller: noteController,
            onChange: (value) => _setNote(value),
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
              Expanded(
                child: AppButton(
                  marginRight: SpacingUnit.x2,
                  color: colors.background,
                  colorBorder: colors.blue,
                  colorText: colors.blue,
                  title: appLocalizations.cancel,
                  onSubmit: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Expanded(
                child: AppButton(
                  marginLeft: SpacingUnit.x2,
                  colorBorder: colors.blue,
                  color: colors.blue,
                  onSubmit: () => _setCall(context),
                  title: appLocalizations.ok,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _setCall(BuildContext context) {
    if (noteController.text != '') {
      Navigator.of(context).pop();
      widget.callback.call();
    }
  }

  _setNote(String value) {
    widget.noteChange.call(value);
  }
}
