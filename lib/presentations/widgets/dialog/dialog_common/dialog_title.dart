import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
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
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
          ElevatedButton(
            onPressed: () => setApply(),
            style: ElevatedButton.styleFrom(
              backgroundColor: colors.navy,
            ),
            child: Text(
              appLocalizations.ok,
              style: TextStyle(color: colors.text),
            ),
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
