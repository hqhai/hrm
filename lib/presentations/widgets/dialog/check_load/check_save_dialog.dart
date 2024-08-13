import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class CheckSaveDialog extends StatelessWidget {
  const CheckSaveDialog({super.key, this.title = '', required this.callback});

  final String title;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(SpacingUnit.x2),
              child: Text(
                title,
                style: TextStyle(
                  color: colors.text,
                  fontWeight: FontWeight.w600,
                  fontSize: SpacingUnit.x4,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x2),
                    child: AppButton(
                      onSubmit: () => cancel(context),
                      title: appLocalizations.cancel,
                      colorText: colors.background,
                      color: colors.text.withOpacity(0.3),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x2),
                    child: AppButton(
                      onSubmit: () => save(context),
                      title: appLocalizations.save,
                      colorText: colors.background,
                      color: colors.blue,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  cancel(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  save(BuildContext context) {
    callback.call();
  }
}

dialogCheckSave(
    {required BuildContext context, required String title, required VoidCallback callback}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: CheckSaveDialog(
            title: title,
            callback: () => callback.call(),
          ),
        ),
      );
    },
  );
}
