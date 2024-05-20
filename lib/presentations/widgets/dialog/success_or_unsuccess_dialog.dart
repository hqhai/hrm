import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';

successDialog(BuildContext context) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.success,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x8)),
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

unsuccessfulDialog(BuildContext context) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.unsuccessful,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x8)),
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