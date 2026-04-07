import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_school.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_event.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_bloc.dart';
import 'package:base_app/presentations/bloc/work_sheet/work_sheet_event.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/time_keeping/list_school/button_timekeeping_item.dart';
import 'package:base_app/presentations/widgets/time_keeping/list_school/list_school_widget.dart';
import 'package:base_app/presentations/widgets/time_keeping/list_school/shift_timekeeping_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:themes/themes.dart';

final timekeepingGPSSchoolPageRoute = GoRoute(
    path: Pages.timekeepingGPSSchool,
    name: Pages.timekeepingGPSSchool,
    builder: (context, GoRouterState state) {
      return const TimekeepingGPSSchoolPage();
    });

class TimekeepingGPSSchoolPage extends StatefulWidget {
  const TimekeepingGPSSchoolPage({
    super.key,
  });

  @override
  State<TimekeepingGPSSchoolPage> createState() =>
      _TimekeepingGPSSchoolPageState();
}

class _TimekeepingGPSSchoolPageState extends State<TimekeepingGPSSchoolPage> {
  ScheduleSchool scheduleSchool = const ScheduleSchool();
  Position? latLngFsel;
  bool checkClick = true, checkPermission = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(appLocalizations.timeKeeping,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
        builder: (context, state) {
          return Container(
            width: width,
            color: colors.text.withValues(alpha: 0.05),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                            top: SpacingUnit.x4,
                            right: SpacingUnit.x4,
                            left: SpacingUnit.x4,
                          ),
                          child: ShiftTimekeepingItem(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: SpacingUnit.x4,
                          ),
                          child: ListSchoolWidget(
                            scheduleSchoolId: scheduleSchool.id,
                            onChange: (value) => setSchool(
                                value: value,
                                schools: state.scheduleSchools.scheduleSchools),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ButtonTimekeepingItem(
                  callBackHistoryTimekeeping: () =>
                      nextHistoryTimekeepingScreen(context),
                  callBackTimekeeping: () =>
                      timekeeping(context, scheduleSchool.id),
                  checkClick: scheduleSchool.id != '',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  setSchool({required String value, required List<ScheduleSchool> schools}) {
    setState(() {
      scheduleSchool = schools.firstWhere((element) => element.id == value);
    });
  }

  nextHistoryTimekeepingScreen(BuildContext context) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    final Completer completer = Completer<bool>();
    dialogIndicator(context: currentContext);
    dI<WorkSheetBloc>().add(GetAttendancesByDateEvent(
      date: DateTime.now(),
      userId: dI<UserBloc>().state.user.id,
      completer: completer,
    ));
    final checkCompleter = await completer.future;
    if (checkCompleter) {
      if (!currentContext.mounted) return;
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>().push(
        currentContext,
        page: Pages.timekeepingGPSSHistory,
      );
    }
  }

  timekeeping(BuildContext context, String schoolId) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (scheduleSchool.id == '') {
      showToastTimeKeeping(
          context: context, errorCode: appLocalizations.chooseASchedule);
    } else if (checkClick) {
      _determinePosition(context, schoolId);
    }
  }

  Future<void> _determinePosition(BuildContext context, String id) async {
    final appLocalizations = AppLocalizations.of(context)!;
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(appLocalizations.locationServicesAreDisabled);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      setState(() {
        checkPermission = false;
      });
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(appLocalizations.locationPermissionsAreDenied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      if (!context.mounted) return;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Dialog(
            child: _DialogOpenSetting(),
          );
        },
      );
    }
    if (permission != LocationPermission.deniedForever) {
      if (!currentContext.mounted) return;
      dialogIndicator(context: currentContext);
      _setCurrentLocation(id);
    }
  }

  _setCurrentLocation(String id) async {
    checkClick = false;
    latLngFsel = await Geolocator.getCurrentPosition();
    setState(() {});
    checkTimekeeping(id);
  }

  void checkTimekeeping(String id) async {
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    Completer completer = Completer<TimekeepingStatus>();
    dI<CheckInCheckOutGpsBloc>().add(PostTimekeepingGPSRequestEvent(
      latitude: latLngFsel?.latitude ?? 0,
      longitude: latLngFsel?.longitude ?? 0,
      scheduleSchoolId: id,
      completer: completer,
    ));
    final status = await completer.future;
    if (status == TimekeepingStatus.success) {
      if (!currentContext.mounted) return;
      setState(() {
        checkClick = true;
      });
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>().pushName(
        currentContext,
        page: Pages.timekeepingGPSSuccessful,
        extra: {
          'scheduleSchoolId': scheduleSchool.id,
        },
      );
    } else if (status == TimekeepingStatus.distanceNotEnough ||
        status == TimekeepingStatus.fail) {
      if (!currentContext.mounted) return;
      setState(() {
        checkClick = true;
      });
      dI<AppNavigation>().pop(currentContext);
      dI<AppNavigation>().pushName(
        currentContext,
        page: Pages.timekeepingGPSUnsuccessful,
        extra: {
          'scheduleSchoolId': scheduleSchool.id,
          'latitude': latLngFsel?.latitude ?? 0,
          'longitude': latLngFsel?.longitude ?? 0,
        },
      );
    }
  }
}

class _DialogOpenSetting extends StatelessWidget {
  const _DialogOpenSetting();

  _onClose(context) {
    Navigator.pop(context);
  }

  _openSetting(context) {
    Navigator.pop(context);
    Geolocator.openLocationSettings();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Container(
      height: MediaQuery.sizeOf(context).height / 4.5,
      padding: const EdgeInsets.all(SpacingUnit.x4),
      decoration: BoxDecoration(
          color: colors.background,
          borderRadius: BorderRadius.circular(SpacingUnit.x4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              _onClose(context);
            },
            child: Container(
                width: MediaQuery.sizeOf(context).width,
                alignment: Alignment.topRight,
                child: const Icon(Icons.close)),
          ),
          const SizedBox(height: SpacingUnit.x3),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x10),
            child: Text(
              appLocalizations.contentPopUpOpenGPS,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: SpacingUnit.x4),
          AppButton(
            color: colors.blue,
            colorText: colors.background,
            title: appLocalizations.allow,
            onSubmit: () => _openSetting(context),
          )
        ],
      ),
    );
  }
}
