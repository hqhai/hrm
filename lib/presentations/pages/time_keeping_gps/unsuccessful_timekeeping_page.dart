import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/timekeeping/schedule_school.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_bloc.dart';
import 'package:base_app/presentations/bloc/location/schedule_school/schedule_school_state.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/time_keeping/item_time_keeping_gps.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';
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
  State<UnSuccessfulTimekeepingPage> createState() =>
      _UnSuccessfulTimekeepingPageState();
}

class _UnSuccessfulTimekeepingPageState
    extends State<UnSuccessfulTimekeepingPage> {
  late MaplibreMapController? _mapController;

  ScheduleSchool _school(List<ScheduleSchool> listSchool) {
    return listSchool
        .firstWhere((element) => element.id == widget.scheduleSchoolId);
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
                            padding: const EdgeInsets.symmetric(
                                vertical: SpacingUnit.x3),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(SpacingUnit.x2)),
                              child: MaplibreMap(
                                attributionButtonPosition: null,
                                onMapCreated: (controller) {
                                  setState(() {
                                    _mapController = controller;
                                  });
                                },
                                onStyleLoadedCallback: () =>
                                    _onStyleLoadedCallback(),
                                styleString:
                                    'https://tiles.goong.io/assets/goong_satellite.json?api_key=o88RMDWHRyeOZfzpG3jhn8JlU4Z0oa6R3kAKnMVu',
                                initialCameraPosition: const CameraPosition(
                                  target: LatLng(
                                      21.03357551700003, 105.81911236900004),
                                  zoom: 14.0,
                                ),
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

  Future<void> _onStyleLoadedCallback() async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Map loading..."),
        backgroundColor: Theme.of(context).primaryColor,
        duration: const Duration(seconds: 2),
      ),
    );
    if (_mapController == null) {
      debugPrint("Map controller is not initialized");
      return;
    }

    await _loadMyPositionMarkerImage();

    await _addMyPositionMarker();
  }

  Future<void> _addMyPositionMarker() async {
    if (_mapController == null) {
      return;
    }

    try {
      await _mapController?.addSymbol(
        SymbolOptions(
          geometry: LatLng(widget.latitude, widget.longitude),
          iconImage: 'myLocation',
          iconSize: 1,
        ),
      );

      final school = _school(
              dI<ScheduleSchoolBloc>().state.scheduleSchools.scheduleSchools)
          .school;

      await _mapController?.addSymbol(
        SymbolOptions(
          geometry: LatLng(school.latitude, school.longitude),
          iconImage: 'mySchoolLocation',
          iconSize: 0.2,
        ),
      );

      await _moveToMyPosition();
    } catch (e) {
      debugPrint("Error adding marker: $e");
    }
  }

  Future<void> _moveToMyPosition() async {
    try {
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
            LatLng(widget.latitude, widget.longitude), 20),
      );
    } catch (e) {
      debugPrint("Error moving to my position: $e");
    }
  }

  Future<void> _loadMyPositionMarkerImage() async {
    try {
      final ByteData bytes =
          await rootBundle.load(Assets.images.icon.icMyPosition.path);
      _mapController?.addImage('myLocation', bytes.buffer.asUint8List());
      final ByteData byteSchool =
          await rootBundle.load(Assets.images.icon.schoolMarker.path);
      _mapController?.addImage(
          'mySchoolLocation', byteSchool.buffer.asUint8List());
    } catch (e) {
      rethrow;
    }
  }
}
