import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/school.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';

final timekeepingGPSUnsuccessfulRoute = GoRoute(
    path: Pages.timekeepingGPSUnsuccessful,
    name: Pages.timekeepingGPSUnsuccessful,
    builder: (context, GoRouterState state) {
      Map data = state.extra as Map;
      return UnSuccessfulTimekeepingPage(
        scheduleSchoolId: data['scheduleSchoolId'],
        longitude: data['longitude'],
        latitude: data['latitude'],
      );
    });

class UnSuccessfulTimekeepingPage extends StatefulWidget {
  const UnSuccessfulTimekeepingPage({
    super.key,
    required this.scheduleSchoolId,
    required this.latitude,
    required this.longitude,
  });

  final String scheduleSchoolId;
  final double latitude, longitude;

  @override
  State<UnSuccessfulTimekeepingPage> createState() => _UnSuccessfulTimekeepingPageState();
}

class _UnSuccessfulTimekeepingPageState extends State<UnSuccessfulTimekeepingPage> {
  Set<Marker> _markers = {};

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

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<ScheduleSchoolBloc, ScheduleSchoolState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: colors.text),
          ),
          body: Padding(
            padding: const EdgeInsets.only(
                left: SpacingUnit.x4,
                top: SpacingUnit.x6,
                bottom: SpacingUnit.x8,
                right: SpacingUnit.x4),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Image.asset(
                          Assets.images.timeKeeping.fail.path,
                          fit: BoxFit.fill,
                          height: SpacingUnit.x20,
                          width: SpacingUnit.x20,
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        Text(
                          appLocalizations.contentDialogTimeKeepingUnSuccess,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: SpacingUnit.x5,
                            color: colors.error,
                          ),
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        Text(
                          appLocalizations.moveToTheAppropriate,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: colors.text,
                            fontSize: SpacingUnit.x4,
                          ),
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        SizedBox(
                          height: SpacingUnit.x59,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x2)),
                              child: GoogleMap(
                                myLocationEnabled: true,
                                initialCameraPosition: CameraPosition(
                                  target: LatLng(widget.latitude, widget.longitude),
                                  zoom: 15,
                                ),
                                markers: _markers,
                                mapType: MapType.normal,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: SpacingUnit.x4),
                        ContainerBorder(
                          marginTop: 0,
                          borderColors: colors.text.withOpacity(0.1),
                          child: ItemTimeKeepingGPS(
                            scheduleSchoolId: widget.scheduleSchoolId,
                            checkSuccessful: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                AppButton(
                  title: appLocalizations.retry,
                  onSubmit: () => _complete(context),
                  color: colors.blue.withOpacity(0.3),
                  colorText: colors.primary,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _complete(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }
}
