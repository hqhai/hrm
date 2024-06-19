import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_area.dart';
import 'package:flutter/material.dart';

noteDialog(BuildContext context, ValueChanged<String> noteChange ,VoidCallback callback) async {
  final TextEditingController noteController = TextEditingController();
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      return AlertDialog(
        content: SizedBox(
          child: Column(
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
                onChange: (value) => noteChange.call(value),
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => callback.call(),
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
        ),
      );
    },
  );
}

