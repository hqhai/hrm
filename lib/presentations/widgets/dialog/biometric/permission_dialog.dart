import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:open_settings/open_settings.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key, required this.callBack});
  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            appLocalizations.permissionBiometric,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: SpacingUnit.x5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _ok(context, callBack),
                child: Text(appLocalizations.ok),
              ),
              ElevatedButton(
                onPressed: () => _setting(context, callBack),
                child: Text(appLocalizations.setting),
              ),
            ],
          )
        ],
      ),
    );
  }
  _setting(BuildContext context, VoidCallback callBack) {
    OpenSettings.openBiometricEnrollSetting();
    callBack.call();
    dI<AppNavigation>().pop(context);
  }

  _ok(BuildContext context, VoidCallback callBack) {
    dI<AppNavigation>().pop(context);
  }

}


