import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/dialog_in_status/dialog.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

permissionDialog(BuildContext context, VoidCallback callBack) async {
  final appLocalizations = AppLocalizations.of(context)!;
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Scrollbar(
          child: Text(appLocalizations.permissionBiometric,
              textAlign: TextAlign.center, style: const TextStyle(fontSize: SpacingUnit.x5)),
        ),
        actions: <Widget>[
          ElevatedButton(
            onPressed: () => _ok(context, callBack),
            child: Text(appLocalizations.ok),
          ),
          ElevatedButton(
            onPressed: () => _setting(context, callBack),
            child: Text(appLocalizations.setting),
          ),
        ],
      );
    },
  );
}

_setting(BuildContext context, VoidCallback callBack) {
  OpenSettings.openBiometricEnrollSetting();
  callBack.call();
  popDialog(context);
}


_ok(BuildContext context, VoidCallback callBack) {
  callBack.call();
  popDialog(context);
}