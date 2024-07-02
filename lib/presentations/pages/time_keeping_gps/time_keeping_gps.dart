import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/custom/app_container_screen_main.dart';
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
    builder: (context, GoRouterState state) => const TimekeepingGPSPage());

class TimekeepingGPSPage extends StatefulWidget {
  const TimekeepingGPSPage({super.key, this.latLngFsel = const LatLng(21.002850, 105.865951)});

  final LatLng latLngFsel;

  @override
  State<TimekeepingGPSPage> createState() => _TimekeepingGPSPageState();
}

class _TimekeepingGPSPageState extends State<TimekeepingGPSPage> {
  Position? _currentLocation;
  late LocationPermission permission;
  Set<Marker> _markers = {};
  LatLng locationSchool = const LatLng(21.003016, 105.861669);
  LatLng? latLngFsel;
  late GoogleMapController _controller;
  bool checkLocation = false;

  @override
  void initState() {
    _markers = {
      Marker(
          markerId: const MarkerId('customMarker1'),
          position: locationSchool,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed))
    };
    super.initState();
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
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return ContainerScreenMain(
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
                        markers: _markers,
                        mapType: MapType.normal,
                        initialCameraPosition: CameraPosition(
                          target: latLngFsel ?? locationSchool,
                          zoom: 15,
                        ),
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
  }
}
