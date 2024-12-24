import 'package:base_app/common/routers/pages.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

final mapLocationRoute = GoRoute(
    path: Pages.mapLocation,
    builder: (context, GoRouterState state) => const MapLocation());

class MapLocation extends StatefulWidget {
  const MapLocation({super.key});

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  late Position? _myPosition;
  late MaplibreMapController? _mapController;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getLocation() async {
    _myPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MaplibreMap(
              attributionButtonPosition: null,
              onMapCreated: (controller) {
                setState(() {
                  _mapController = controller;
                });
              },
              onStyleLoadedCallback: () => _onStyleLoadedCallback(),
              styleString:
                  'https://tiles.goong.io/assets/goong_satellite.json?api_key=o88RMDWHRyeOZfzpG3jhn8JlU4Z0oa6R3kAKnMVu',
              initialCameraPosition: const CameraPosition(
                target: LatLng(21.03357551700003, 105.81911236900004),
                zoom: 14.0,
              ),
            ),
            Positioned(
                top: 16,
                left: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(90),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async => await _moveToMyPosition(),
        label: const Text('My Location'),
        icon: const Icon(Icons.location_on),
      ),
    );
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

    await _getLocation();

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
          geometry:
              LatLng(_myPosition?.latitude ?? 0, _myPosition?.longitude ?? 0),
          iconImage: 'myLocation',
          iconSize: 1,
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
            LatLng(_myPosition?.latitude ?? 0, _myPosition?.longitude ?? 0),
            20),
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
    } catch (e) {
      rethrow;
    }
  }
}
