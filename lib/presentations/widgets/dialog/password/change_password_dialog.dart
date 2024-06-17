import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';

successFullChangePasswordDialog(BuildContext context, String content) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(content,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.white)),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => popDialog(context),
            child: Text(appLocalizations.ok),
          ),
        ],
      );
    },
  );
}

changePasswordDialog(BuildContext context, VoidCallback callback) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(
            appLocalizations.doYouWantToChangeYourPassword,
            style: const TextStyle(fontSize: SpacingUnit.x6, color: Colors.white),
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => onClickOK(context, callback),
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



