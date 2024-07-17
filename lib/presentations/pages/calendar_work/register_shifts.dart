import 'dart:core';

import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:themes/themes.dart';

final registerShiftsPageRoute = GoRoute(
  path: Pages.registerShiftsPage,
  name: Pages.registerShiftsPage,
  builder: (context, GoRouterState state) => const RegisterShiftsPage(),
);

class RegisterShiftsPage extends StatefulWidget {
  const RegisterShiftsPage({super.key});

  @override
  State<RegisterShiftsPage> createState() => _RegisterShiftsPageState();
}

class _RegisterShiftsPageState extends State<RegisterShiftsPage> {
  DateTime currentDateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  List<DateTime> listDays() {
    int nowOfWeek = mapNumberDayInWeek[DateFormat('EEE').format(currentDateTime)] ?? 0;
    DateTime startOfWeek = currentDateTime.subtract(Duration(days: nowOfWeek - 1));
    List<DateTime> daysOfWeek = [];
    for (int i = 0; i < 7; i++) {
      DateTime day = startOfWeek.add(Duration(days: i));
      daysOfWeek.add(day);
    }
    return daysOfWeek;
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          appLocalizations.registerShift,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
      body: ContainerScreenMain(
        child: Column(
          children: [
            weekOnCalendar(context),
            SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                children: listDays()
                    .mapIndexed((index, element) =>
                        Expanded(flex: 1, child: itemDayOfWeek(index, element, context)))
                    .toList(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget weekOnCalendar(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final DateTime firstDayOfMonth = DateTime(currentDateTime.year, currentDateTime.month, 1);
    final int daysSinceFirstDay = currentDateTime.difference(firstDayOfMonth).inDays;
    final int weekOfMonth = (daysSinceFirstDay / 7).ceil();
    return Row(
      children: [
        SvgPicture.asset(
          Assets.images.timeKeeping.calendar,
          colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
        ),
        const SizedBox(
          width: SpacingUnit.x1,
        ),
        Text(
          '${appLocalizations.week} $weekOfMonth',
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
        ),
        const SizedBox(
          width: SpacingUnit.x1,
        ),
        Text(
          '${appLocalizations.month} ${currentDateTime.month}',
          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
        ),
        InkWell(
          onTap: () => setDownWeek(),
          child: Icon(
            Icons.chevron_left,
            size: SpacingUnit.x8,
            color: colors.text,
          ),
        ),
        InkWell(
          onTap: () => setUpWeek(),
          child: Icon(
            Icons.chevron_right,
            size: SpacingUnit.x8,
            color: colors.text,
          ),
        ),
      ],
    );
  }

  Widget itemDayOfWeek(
    int index,
    DateTime time,
    BuildContext context,
  ) {
    final colors = AppTheme.getColors(context);
    final bool checkNow = time.day == DateTime.now().day;
    return ContainerBorder(
      borderColors: colors.surface,
      backgroundColors: checkNow ? colors.surfaceVariant : colors.surface,
      child: Column(
        children: [
          Text(
            mapNameInWeek[index + 1] ?? "",
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
          ),
          Text(
            time.day.toString(),
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
          ),
        ],
      ),
    );
  }

  setDownWeek() {
    setState(() {
      currentDateTime = currentDateTime.subtract(const Duration(days: 7));
    });
  }

  setUpWeek() {
    setState(() {
      currentDateTime = currentDateTime.add(const Duration(days: 7));
    });
  }
}
