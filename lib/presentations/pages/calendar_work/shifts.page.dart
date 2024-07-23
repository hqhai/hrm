import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/calendar_work/calender/shifts_content.widget.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final shiftsPageRoute = GoRoute(
    path: Pages.shiftsPage,
    name: Pages.shiftsPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return ShiftsPage(
        id: data['id'],
      );
    });

class ShiftsPage extends StatelessWidget {
  const ShiftsPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(),
      body: ContainerScreenMain(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ShiftsContentWidget(
                  id: id,
                ),
              ],
            ),
            AppButton(title: appLocalizations.registerShift, onSubmit:() => onSubmit())
          ],
        ),
      ),
    );
  }

  onSubmit() {}
}
