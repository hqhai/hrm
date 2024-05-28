import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/dialog.dart';
import 'package:flutter/material.dart';

notRegisteredForBiometricsDialog(BuildContext context) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.notRegisteredForBiometrics,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x8)),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => popDialog(context),
            child: Text(appLocalizations.cancel),
          ),
        ],
      );
    },
  );
}

registeredForBiometricsDialog(BuildContext context, VoidCallback callback) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.youWantToSaveTheAboveAccountForBiometrics,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x8)),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => callback.call(),
                child: Text(appLocalizations.save),
              ),
              ElevatedButton(
                onPressed: () => popDialog(context),
                child: Text(appLocalizations.cancel),
              ),
            ],
          ),
        ],
      );
    },
  );
}

biometricsLoginErrorDialog(BuildContext context) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.yourBiometricAccountIsIncorrect,
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
