import 'dart:async';

import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_bloc.dart';
import 'package:base_app/presentations/bloc/check_in_check_out_gps/check_in_check_out_gps_event.dart';
import 'package:base_app/presentations/bloc/location/school/school_bloc.dart';
import 'package:base_app/presentations/bloc/location/school/school_state.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
import 'package:base_app/presentations/widgets/dialog/check_load/check_load_dialog_timekeeping.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final timekeepingGPSPageRoute = GoRoute(
    path: Pages.timekeepingGPSPage,
    name: Pages.timekeepingGPSPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return TimekeepingGPSPage(
        idSchool: data['idSchool'],
      );
    });

class TimekeepingGPSPage extends StatefulWidget {
  const TimekeepingGPSPage({super.key, this.idSchool = ''});

  final String idSchool;

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

  @override
  void initState() {
    super.initState();
  }

  LatLng getSchoolById(Map schools) {
    final School school = schools[widget.idSchool];
    final LatLng locationSchool = LatLng(school.latitude, school.longitude);
      _markers = {
        Marker(
            markerId: const MarkerId('customMarker1'),
            position: LatLng(school.latitude, school.longitude),
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed))
      };
    return locationSchool;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.timeKeeping,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocBuilder<SchoolBloc, SchoolState>(
        builder: (context, state) {
          return Stack(
            children: [
              ContainerScreenMain(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ItemTimeKeepingGPS(),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                          child: GoogleMap(
                            myLocationEnabled: checkLocation,
                            onMapCreated: (GoogleMapController controller) => setCamera(controller),
                            initialCameraPosition: CameraPosition(
                              target: latLngFsel ??
                                  getSchoolById(
                                    state.schools
                                  ),
                              zoom: 15,
                            ),
                            markers: _markers,
                            mapType: MapType.normal,

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SpacingUnit.x4),
                        child: AppButton(
                          onSubmit: () async => await _determinePosition(context),
                          title: appLocalizations.timekeepingImmediately,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(SpacingUnit.x4),
                        child: AppButton(
                            onSubmit: () => _nextAttendanceHistoryPage(context),
                            title: appLocalizations.viewAttendanceHistory),
                      ),
                    ],
                  ),
                ),
              ),
              CheckLoadTimekeepingDialog(
                checkUnSuccess: checkUnSuccess,
                checkSuccess: checkSuccess,
                checkLoad: checkLoad,
                checkUnSuccessChange: () => setDialog(),
                checkSuccessChange: () => setDialog(),
              ),
            ],
          );
        },
      ),
    );
  }

  setCamera(GoogleMapController controller) {
    _controller = controller;
  }

  _nextAttendanceHistoryPage(BuildContext context) {
    dI<AppNavigation>().pushName(context, page: Pages.timekeepingGPSCheckPage, extra: {
      'latLng': LatLng(
        _currentLocation?.longitude ?? 0,
        _currentLocation?.latitude ?? 0,
      ),
      'dateTime': DateTime.now()
    });
  }

  Future<void> _determinePosition(BuildContext context) async {
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
      return Future.error(appLocalizations.locationPermissionsArePermanentlyDenied);
    }
    final position = await Geolocator.getCurrentPosition();
    _setCurrentLocation(position);
  }

  _setCurrentLocation(Position position) {
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
    checkTimekeeping();
  }

  void checkTimekeeping() async {
    setState(() {
      checkLoad = true;
    });
    Completer completer = Completer<TimekeepingStatus>();
    dI<CheckInCheckOutGpsBloc>().add(PostTimekeepingGPSRequestEvent(
      latitude: latLngFsel?.latitude ?? 0,
      longitude: latLngFsel?.longitude ?? 0,
      time: DateTime.now(),
      completer: completer,
    ));
    final status = await completer.future;
    if (status == TimekeepingStatus.success) {
      setState(() {
        checkLoad = false;
        checkSuccess = true;
      });
    } else if (status == TimekeepingStatus.fail) {
      checkLoad = false;
      checkUnSuccess = true;
    }
  }

  setDialog() {
    setState(() {
      checkSuccess = false;
      checkUnSuccess = false;
    });
  }
}
