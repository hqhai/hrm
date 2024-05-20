import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';

deleteDialog(BuildContext context, VoidCallback callback) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(
            appLocalizations.doYouWantToDeleteTheRoom,
            style: const TextStyle(fontSize: SpacingUnit.x6, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () {
              callback.call();
              Navigator.of(context).pop();
            },
            child: Text(
              appLocalizations.ok,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white),
            ),
          ),
          ElevatedButton(
            child: Text(
              appLocalizations.cancel,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white),
            ),
            onPressed: () => popDialog(context),
          ),
        ],
      );
    },
  );
}
