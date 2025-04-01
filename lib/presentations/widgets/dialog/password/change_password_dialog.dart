import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ChangePassWord extends StatelessWidget {
  const ChangePassWord({super.key, required this.callBack});

  final VoidCallback callBack;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              appLocalizations.doYouWantToChangeYourPassword,
              style: TextStyle(
                fontSize: SpacingUnit.x6,
                color: colors.text,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      colorText: colors.background,
                      onSubmit: () => onClickOK(),
                      title: appLocalizations.apply,
                      color: colors.blue,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      onSubmit: () => popDialog(),
                      colorText: colors.background,
                      color: colors.text.withValues(alpha: 0.3),
                      title: appLocalizations.cancel,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  onClickOK() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    callBack.call();
    dI<AppNavigation>().pop(currentContext);
  }

  popDialog() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
  }
}

changePasswordDialog(
    {required BuildContext context, required VoidCallback callback}) async {
  return showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: ChangePassWord(
          callBack: () => callback.call(),
        ),
      );
    },
  );
}
