import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final timekeepingGPSSuccessfulRoute = GoRoute(
    path: Pages.timekeepingGPSSuccessful,
    name: Pages.timekeepingGPSSuccessful,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return SuccessfulTimekeepingPage(
        scheduleSchoolId: data['scheduleSchoolId'],
      );
    });

class SuccessfulTimekeepingPage extends StatelessWidget {
  const SuccessfulTimekeepingPage({super.key, required this.scheduleSchoolId});

  final String scheduleSchoolId;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: SpacingUnit.x4,
          top: SpacingUnit.x6,
          bottom: SpacingUnit.x8,
          right: SpacingUnit.x4,
        ),
        child: Column(
          children: [
            Image.asset(
              Assets.images.timeKeeping.allow.path,
              fit: BoxFit.fill,
              height: SpacingUnit.x20,
              width: SpacingUnit.x20,
            ),
            const SizedBox(height: SpacingUnit.x4),
            Text(
              appLocalizations.timekeepingSuccess,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: SpacingUnit.x6,
                color: colors.success,
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
            Text(
              formatMSDMY(DateTime.now().toString()),
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
            const SizedBox(height: SpacingUnit.x4),
            ContainerBorder(
              backgroundColors: colors.background,
              borderColors: colors.text.withOpacity(0.3),
              child: ItemTimeKeepingGPS(scheduleSchoolId: scheduleSchoolId),
            ),
            const SizedBox(height: SpacingUnit.x4),
            AppButton(
              title: appLocalizations.complete,
              color: colors.blue.withOpacity(0.3),
              colorText: colors.primary,
              onSubmit: () => _complete(context),
            ),
          ],
        ),
      ),
    );
  }

  _complete(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}
