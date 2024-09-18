import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/trash_app/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TitleDialog extends StatelessWidget {
  const TitleDialog({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          AppButton(
            onSubmit: () => setApply(),
            title: appLocalizations.ok,
          ),
        ],
      ),
    );
  }

  setApply() {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dI<AppNavigation>().pop(currentContext);
  }
}

updateNoteDialog({required BuildContext context, required VoidCallback callBack, required String title}) async {
  return showDialog(
    context: context,
    builder: (context) {
      final appLocalizations = AppLocalizations.of(context)!;
      final colors = AppTheme.getColors(context);
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: SpacingUnit.x4, color: Colors.black),
            ),
            const SizedBox(
              height: SpacingUnit.x4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
                    child: AppButton(
                      title: appLocalizations.ok,
                      onSubmit: () => callBack.call(),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
                    child: AppButton(
                      colorText: colors.blue,
                      color: colors.background,
                      colorBorder: colors.blue,
                      title: appLocalizations.cancel,
                      onSubmit: () => closePopUp(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
