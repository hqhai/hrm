import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/error_response.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_event.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_state.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/activate/requisition_infor_item/item/item_title_value_no_border.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog_timekeeping.dart';
import 'package:base_app/presentations/widgets/dialog/progress_indicator_dialog.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';

final timekeepingGPSPageRoute = GoRoute(
  path: Pages.timekeepingGPSPage,
  name: Pages.timekeepingGPSPage,
  builder: (context, GoRouterState state) => const TimekeepingGPSPage(),
);

class TimekeepingGPSPage extends StatefulWidget {
  const TimekeepingGPSPage({
    super.key,
  });

  @override
  State<TimekeepingGPSPage> createState() => _TimekeepingGPSPageState();
}

class _TimekeepingGPSPageState extends State<TimekeepingGPSPage> {
  Position? _currentLocation;
  late LocationPermission permission;
  Set<Marker> _markers = {};
  LatLng? latLngFsel;
  late GoogleMapController _controller;
  bool checkLocation = false,
      checkLoad = false,
      checkSuccess = false,
      checkUnSuccess = false,
      checkClick = false;
  DateTime? time;
  String error = '';

  @override
  void initState() {
    super.initState();
  }

  LatLng getSchoolById(School? school) {
    final LatLng locationSchool =
        LatLng(school?.latitude ?? 105.865963, school?.longitude ?? 21.002852);
    _markers = {
      Marker(
        markerId: const MarkerId('customMarker1'),
        position: locationSchool,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ),
    };
    return locationSchool;
  }

  _listener(BuildContext context, CheckInCheckOutGpsState state) {
    setState(() {
      error = setErrorValue(state.errorCode, context) ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: colors.text),
        title: Text(appLocalizations.timeKeeping,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: Container(
        color: colors.text.withOpacity(0.1),
        child: BlocListener<CheckInCheckOutGpsBloc, CheckInCheckOutGpsState>(
          listener: (context, state) => _listener(context, state),
          child: BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x4),
                      child: ContainerBorder(
                        borderColors: colors.background,
                        backgroundColors: colors.background,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appLocalizations.map,
                              style: TextStyle(
                                color: colors.text,
                                fontSize: SpacingUnit.x3_5,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: SpacingUnit.x3),
                                      child: GoogleMap(
                                        myLocationEnabled: checkLocation,
                                        onMapCreated:
                                            (GoogleMapController controller) =>
                                                setCamera(controller),
                                        initialCameraPosition: CameraPosition(
                                          target: latLngFsel ??
                                              getSchoolById(
                                                  state.scheduleSchool.school),
                                          zoom: 15,
                                        ),
                                        markers: _markers,
                                        mapType: MapType.normal,
                                      ),
                                    ),
                                  ),
                                  const ItemTimeKeepingGPS(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    child: ContainerBorder(
                      marginTop: 0,
                      borderColors: colors.background,
                      backgroundColors: colors.background,
                      child: ItemTitleValueNoBorder(
                        size: SpacingUnit.x3_5,
                        font: FontWeight.w600,
                        title: appLocalizations.timekeepingTime,
                        value: formatYMD((time ?? "").toString()),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(SpacingUnit.x4),
                    child: AppButton(
                      colorText: colors.background,
                      onSubmit: () async => await _determinePosition(
                          context, state.scheduleSchool.id),
                      title: appLocalizations.timekeepingImmediately,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  setCamera(GoogleMapController controller) {
    _controller = controller;
  }

  Future<void> _determinePosition(BuildContext context, String id) async {
    final appLocalizations = AppLocalizations.of(context)!;
    setState(() {
      checkLoad = true;
    });
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(appLocalizations.locationServicesAreDisabled);
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(appLocalizations.locationPermissionsAreDenied);
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Geolocator.openLocationSettings();
      return Future.error(
          appLocalizations.locationPermissionsArePermanentlyDenied);
    }
    final position = await Geolocator.getCurrentPosition();
    _setCurrentLocation(position, id);
  }

  _setCurrentLocation(Position position, String id) {
    setState(() {
      checkLocation = true;
      _currentLocation = position;
      double lo = _currentLocation?.longitude ?? 0;
      double la = _currentLocation?.latitude ?? 0;
      latLngFsel = LatLng(la, lo);
      _controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(la, lo)),
      );
    });
    checkTimekeeping(id);
  }

  void checkTimekeeping(String id) async {
    setState(() {
      checkLoad = true;
    });
    final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
    dialogIndicator(context: currentContext);
    Completer completer = Completer<TimekeepingStatus>();
    dI<CheckInCheckOutGpsBloc>().add(PostTimekeepingGPSRequestEvent(
      latitude: latLngFsel?.latitude ?? 0,
      longitude: latLngFsel?.longitude ?? 0,
      scheduleSchoolId: id,
      completer: completer,
    ));
    final status = await completer.future;
    if (status == TimekeepingStatus.success) {
      setState(() {
        time = DateTime.now();
      });
      if (!currentContext.mounted) return;
      dialogTimeKeepingSuccess(
        context: currentContext,
      );
      setState(() {
        error = '';
      });
    } else if (status == TimekeepingStatus.fail) {
      if (!currentContext.mounted) return;
      dialogTimeKeepingSuccess(
        context: currentContext,
      );
    } else if (status == TimekeepingStatus.distanceNotEnough) {
      if (!currentContext.mounted) return;
      dialogTimeKeepingUnSuccess(
        context: currentContext,
      );
    }
  }

  dialogTimeKeepingSuccess({required BuildContext context}) {
    final colors = AppTheme.getColors(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: colors.background,
          surfaceTintColor: colors.background,
          child: const SingleChildScrollView(
            child: TimeKeepingSuccess(),
          ),
        );
      },
    ).then((value) {
      dI<AppNavigation>().pop(context);
      dI<AppNavigation>().pop(context);
    });
  }

  dialogTimeKeepingUnSuccess({required BuildContext context}) {
    final colors = AppTheme.getColors(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: colors.background,
          surfaceTintColor: colors.background,
          child: SingleChildScrollView(
            child: TimeKeepingUnSuccess(title: error),
          ),
        );
      },
    ).then((value) {
      final currentContext = dI<AppNavigation>().navigatorKey.currentContext!;
      dI<AppNavigation>().pop(currentContext);
    });
  }
}
