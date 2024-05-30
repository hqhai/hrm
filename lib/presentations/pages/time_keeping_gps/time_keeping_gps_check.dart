import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/user/user/user_bloc.dart';
import 'package:base_app/presentations/bloc/user/user/user_state.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

final timekeepingGPSCheckPageRoute = GoRoute(
    path: Pages.timekeepingGPSCheckPage,
    name: Pages.timekeepingGPSCheckPage,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return TimekeepingGPSCheckPage(latLng: data['latLng'], dateTime: data['dateTime']);
    });

class TimekeepingGPSCheckPage extends StatefulWidget {
  const TimekeepingGPSCheckPage(
      {super.key,
      this.latLng = const LatLng(0, 0),
      required this.dateTime});

  final LatLng latLng;
  final DateTime dateTime;

  @override
  State<TimekeepingGPSCheckPage> createState() => _TimekeepingGPSCheckPageState();
}

class _TimekeepingGPSCheckPageState extends State<TimekeepingGPSCheckPage> {
  late LocationPermission permission;
  Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _markers = {
      Marker(
          markerId: const MarkerId('customMarker1'),
          position: widget.latLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed))
    };
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.timeKeeping,
            style: TextStyle(fontSize: SpacingUnit.x5, color: colors.text)),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(SpacingUnit.x4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        appLocalizations.validateToolLocation,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x3,
                        ),
                      ),
                      Text(
                        appLocalizations.step,
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x3,
                        ),
                      ),
                    ],
                  ),
                  const ItemTimeKeepingGPS(),
                  const SizedBox(
                    height: SpacingUnit.x4,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SpacingUnit.x4),
                      border: Border.all(
                        color: colors.text,
                        width: 1,
                      ),
                    ),
                    height: width * 0.6,
                    width: width,
                    child: GoogleMap(
                      markers: _markers,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: widget.latLng,
                        zoom: 18,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: SpacingUnit.x15,
                  ),
                  AppButton(
                    onSubmit: () {},
                    title: appLocalizations.complete,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String setAddressDepartment(UserState state) {
    if (state.user.userDepartmentPositions.isNotEmpty) {
      return state.user.userDepartmentPositions.first.department?.address ?? "";
    } else {
      return "";
    }
  }
}
