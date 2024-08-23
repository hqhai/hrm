import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
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
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ContainerBorder(
            borderColors: colors.outline.withOpacity(0.4),
            width: width,
            height: SpacingUnit.x40,
            child: SingleChildScrollView(
              child: Text(
                title,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x5,
                ),
              ),
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
