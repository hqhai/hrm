import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_bloc.dart';
import 'package:base_app/presentations/bloc/attendance/attendance_event.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_event.dart';
import 'package:base_app/presentations/widgets/attendance/layout_calendar.dart';
import 'package:base_app/presentations/widgets/home/item_home_checkin_checkout_gps_widget.dart';
import 'package:base_app/presentations/widgets/home/item_home_infor_widget.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  String id = '';

  @override
  void initState() {
    dI<UserBloc>().add(const GetUserInfo());
    id = dI<UserBloc>().state.user.id;
    dI<AttendanceBloc>()
        .add(GetAttendanceNowEvent(id: id,));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        margin: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2, vertical: SpacingUnit.x2),
        decoration: BoxDecoration(
          color: CustomsColor.colorBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(SpacingUnit.x4),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ItemHomeInforWidget(),
            //const ItemHomeCheckInCheckOutWidget(),
            const ItemHomeCheckInCheckOutGPSWidget(),
            const SizedBox(height: SpacingUnit.x4_5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  appLocalizations.calendar,
                  style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
                ),
                GestureDetector(
                  onTap: () => _nextAttendanceHistoryPage(context),
                  child: Text(
                    appLocalizations.viewAttendanceHistory,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x3,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            const LayoutCalendar(),
          ],
        ),
      ),
    );
  }

  _nextAttendanceHistoryPage(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.layoutCalendarAttendanceHistoryPage);
  }
}
