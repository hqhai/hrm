import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class TimeKeepingSuccess extends StatelessWidget {
  const TimeKeepingSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(SpacingUnit.x4),
        child: SizedBox(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                appLocalizations.timekeepingSuccess,
                style: TextStyle(
                  color: colors.success,
                  fontWeight: FontWeight.w600,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              Image.asset(
                Assets.images.timeKeeping.notoWorldMap.path,
                fit: BoxFit.fill,
                height: SpacingUnit.x50,
                width: SpacingUnit.x50,
              ),
              AppButton(
                onSubmit: () => submit(context),
                title: appLocalizations.complete,
                colorText: colors.background,
                color: colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  submit(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}

class TimeKeepingUnSuccess extends StatelessWidget {
  const TimeKeepingUnSuccess({super.key, this.title = ''});

  final String title;

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
            Text(
              title.isNotEmpty ? title : appLocalizations.timekeepingUnSuccess,
              style: TextStyle(
                color: colors.error,
                fontWeight: FontWeight.w600,
                fontSize: SpacingUnit.x4,
              ),
            ),
            Image.asset(
              Assets.images.timeKeeping.unWorldMap.path,
              fit: BoxFit.fill,
              height: SpacingUnit.x50,
              width: SpacingUnit.x50,
            ),
            AppButton(
              onSubmit: () => submit(context),
              title: appLocalizations.cancel,
              colorText: colors.background,
              color: colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  submit(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}
