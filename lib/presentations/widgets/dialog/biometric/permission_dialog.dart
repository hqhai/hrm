import 'package:app_settings/app_settings.dart';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class PermissionDialog extends StatelessWidget {
  const PermissionDialog({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButton(
                    onSubmit: () => _ok(context, callBack),
                    title: appLocalizations.cancel,
                    colorText: colors.blue,
                    colorBorder: colors.blue,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButton(
                    colorText: colors.background,
                    color: colors.blue,
                    onSubmit: () => _setting(context, callBack),
                    title: appLocalizations.setting,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _setting(BuildContext context, VoidCallback callBack) {
    AppSettings.openAppSettings(type: AppSettingsType.location);
    callBack.call();
    dI<AppNavigation>().pop(context);
  }

  _ok(BuildContext context, VoidCallback callBack) {
    dI<AppNavigation>().pop(context);
  }
}
