import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/widgets/base_page.dart';
import 'package:base_app/presentations/widgets/custom/app_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final historyAttendancePageRoute = GoRoute(
    name: Pages.historyAttendancePage,
    path: Pages.historyAttendancePage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return HistoryAttendancePage(
        attendance: data['attendance'],
      );
    });

class HistoryAttendancePage extends StatefulWidget {
  const HistoryAttendancePage({super.key, required this.attendance});

  final Attendance attendance;

  @override
  State<HistoryAttendancePage> createState() => _HistoryAttendancePageState();
}

class _HistoryAttendancePageState extends State<HistoryAttendancePage> {
  late DateTime date;
  String departmentName = '', note = '';
  final TextEditingController noteController = TextEditingController();

  @override
  void initState() {
    date = DateTime.parse(widget.attendance.attendanceDate);
    departmentName = dI<UserBloc>().state.user.userDepartmentPositions.first.department?.name ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    final appLocalizations = AppLocalizations.of(context)!;
    return BasePage(
      appbar: AppBar(
        title: Text(appLocalizations.history,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: Container(
        margin: const EdgeInsets.all(SpacingUnit.x2),
        padding: const EdgeInsets.all(SpacingUnit.x2),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: const BorderRadius.all(
            Radius.circular(SpacingUnit.x4),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text('${formatWeekDay(date.weekday)} - ${formatYMD(date.toString())}',
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(appLocalizations.checkIn,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4_5)),
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    height: SpacingUnit.x3,
                    Assets.images.icon.home.mingcuteTimeLine,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4_5,
                  ),
                  Text(_checkIn(context),
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                ],
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    height: SpacingUnit.x3,
                    Assets.images.icon.home.icBaselinePlace,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4_5,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: Text(departmentName,
                        maxLines: 3,
                        style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                  ),
                ],
              ),
              const SizedBox(height: SpacingUnit.x4),
              Align(
                alignment: Alignment.topLeft,
                child: Text(appLocalizations.checkOut,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4_5)),
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    height: SpacingUnit.x3,
                    Assets.images.icon.home.mingcuteTimeLine,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4_5,
                  ),
                  Text(_checkOut(context),
                      style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5)),
                ],
              ),
              const SizedBox(
                height: SpacingUnit.x4_5,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    height: SpacingUnit.x3,
                    Assets.images.icon.home.icBaselinePlace,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x4_5,
                  ),
                  SizedBox(
                      width: width * 0.8,
                      child: Text(departmentName,
                          maxLines: 3,
                          style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5))),
                ],
              ),
              const SizedBox(height: SpacingUnit.x4),
              Align(
                alignment: Alignment.topLeft,
                child: Text(appLocalizations.note,
                    style: TextStyle(color: colors.text, fontSize: SpacingUnit.x4_5)),
              ),
              const SizedBox(height: SpacingUnit.x4),
              AppInput(
                maxLines: 6,
                placeHolder: appLocalizations.note,
                controller: noteController,
                onChange: (value) => setNote(value),
              ),
              const SizedBox(height: SpacingUnit.x4),
              AppButton(
                  title: appLocalizations.save,
                  onSubmit: () => onSubmit(),
                  color: checkInput()
                      ? CustomsColor.colorButtonSelect
                      : CustomsColor.colorUnButtonSelect,
                  colorText: checkInput() ? colors.text : CustomsColor.colorTextUnButtonSelect),
            ],
          ),
        ),
      ),
    );
  }

  String _checkIn(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return widget.attendance.checkIn != null
        ? '${widget.attendance.checkIn} ( ${formatWeekDay(date.weekday)} - ${formatYMD(date.toString())} )'
        : appLocalizations.noData;
  }

  String _checkOut(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return widget.attendance.checkOut != null
        ? '${widget.attendance.checkOut} ( ${formatWeekDay(date.weekday)} - ${formatYMD(date.toString())} )'
        : appLocalizations.noData;
  }

  onSubmit() {}

  setNote(String value) {
    setState(() {
      note = value;
    });
  }

  bool checkInput() {
    return note != '';
  }
}
