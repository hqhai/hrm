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
                appLocalizations.contentDialogTimeKeepingSuccess,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              const SizedBox(height: SpacingUnit.x4),
              Image.asset(
                Assets.images.timeKeeping.allow.path,
                fit: BoxFit.fill,
                height: SpacingUnit.x30,
                width: SpacingUnit.x30,
              ),
              const SizedBox(height: SpacingUnit.x4),
              AppButton(
                onSubmit: () => submit(context),
                title: appLocalizations.complete,
                colorText: colors.background,
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
  final VoidCallback onRetry;
  const TimeKeepingUnSuccess(
      {super.key, this.title = '', required this.onRetry});

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
              appLocalizations.contentDialogTimeKeepingUnSuccess,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: SpacingUnit.x4,
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
            Image.asset(
              Assets.images.timeKeeping.fail.path,
              fit: BoxFit.fill,
              height: SpacingUnit.x30,
              width: SpacingUnit.x30,
            ),
            const SizedBox(height: SpacingUnit.x4),
            AppButton(
              onSubmit: () => onRetry.call(),
              title: appLocalizations.retry,
              colorText: colors.background,
            ),
            const SizedBox(height: SpacingUnit.x3),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                  border: Border.all(width: 1, color: colors.outline)),
              child: AppButton(
                onSubmit: () => submit(context),
                title: appLocalizations.cancel,
                colorText: colors.outline,
                color: colors.background,
              ),
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
