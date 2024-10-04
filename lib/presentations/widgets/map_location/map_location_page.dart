import 'dart:async';
import 'dart:convert';
import 'package:base_app/common/routers/pages.dart';
import 'package:http/http.dart' as http;
import 'package:base_app/presentations/widgets/map_location/widget/position_info.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

final mapLocationRoute = GoRoute(
    path: Pages.mapLocation,
    builder: (context, GoRouterState state) => const MapLocation());

class MapLocation extends StatefulWidget {
  const MapLocation({super.key});

  @override
  State<MapLocation> createState() => _MapLocationState();
}

class _MapLocationState extends State<MapLocation> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Set<Marker> markers = {};

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(21.0028598, 105.8632213),
    zoom: 14.4746,
  );

  LatLng? _currentPosition;
  Marker? _destination;
  List<LatLng> locations = [
    const LatLng(21.0028598, 105.8632213),
    const LatLng(21.0043068, 105.8632213),
    const LatLng(21.0070009, 105.8088556),
  ];
  Set<Polyline> polyLines = {};

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  _getLocation() async {
    locations.mapIndexed(
      (index, element) {
        markers.add(
          Marker(
            draggable: true,
            consumeTapEvents: true,
            flat: true,
            visible: true,
            markerId: MarkerId('$index Ids'),
            position: element,
            infoWindow: InfoWindow(
              title: index == 0
                  ? 'Atlantic Group 33 Lạc Trung'
                  : index == 1
                      ? 'Five-Star E-Learning'
                      : 'Atlantic Group  25 Hoàng Ngân',
            ),
            onTap: () => _choiceLocation(index: index),
          ),
        );
      },
    ).toList();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/icon/icon_loaction.png',
    );
    _currentPosition = LatLng(position.latitude, position.longitude);
    markers.add(Marker(
      markerId: const MarkerId('3 Ids'),
      position: LatLng(position.latitude, position.longitude),
      // position: const LatLng(21.067419607000325, 105.74160439495525),
      icon: customIcon,
      infoWindow: const InfoWindow(
        title: 'Vi tri cua toi',
        snippet: '',
      ),
      onTap: () => _choiceLocation(index: 3),
    ));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(children: [
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _currentPosition == null
              ? kGooglePlex
              : CameraPosition(
                  target: LatLng(_currentPosition?.latitude ?? 0,
                      _currentPosition?.longitude ?? 0),
                  zoom: 14.4746,
                ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          polylines: polyLines,
          markers: markers,
          tiltGesturesEnabled: true,
        ),
        if (_destination != null)
          Positioned(
              bottom: 0,
              height: MediaQuery.of(context).size.height / 2,
              child: PositionInfo(
                onClose: () => _closeLocation(),
                marker: _destination!,
                gotoLocation: (value) => _gotoLocation(marker: value),
              )),
      ])),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async => await _goToLocationUser(),
      //   label: const Text('Vi tri cua toi'),
      //   icon: const Icon(Icons.location_history_outlined),
      // ),
    );
  }

  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      polyline.add(LatLng(lat / 1E5, lng / 1E5));
    }
    return polyline;
  }

  void _closeLocation() {
    setState(() {
      _destination = null;
    });
  }

  // _goToLocationUser() async {
  //   final position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   _currentPosition = LatLng(position.latitude, position.longitude);
  //   if (_currentPosition.latitude != 0 &&
  //       _currentPosition.longitude != 0 &&
  //       markers.length < 4) {
  //     markers.add(Marker(
  //       markerId: const MarkerId('3 Ids'),
  //       position: _currentPosition,
  //       infoWindow: const InfoWindow(
  //         title: 'Vi tri cua toi',
  //         snippet: '',
  //       ),
  //       onTap: () => _choiceLocation(index: 3),
  //     ));
  //     // final youLocation = const LatLng(21.0070009, 105.8088556);
  //     // kGooglePlex = CameraPosition(
  //     //   target: youLocation,
  //     //   // target: LatLng(position.latitude, position.longitude),
  //     //   zoom: 14.4746,
  //     // );
  //     setState(() {});
  //   }
  // }

  void _choiceLocation({required int index}) {
    final listMarker = markers.map((e) => e).toList();
    if (index > listMarker.length) {
      return;
    }
    switch (index) {
      case 0:
        _destination = listMarker[index];
      case 1:
        _destination = listMarker[index];
      case 2:
        _destination = listMarker[index];
      case 3:
    }
    polyLines = {};
    setState(() {});
  }

  _gotoLocation({required Marker marker}) async {
    if (_currentPosition == null) return;

    String url = 'https://maps.googleapis.com/maps/api/directions/json?'
        'origin=${_currentPosition?.latitude},${_currentPosition?.longitude}&'
        'destination=${_destination?.position.latitude},${_destination?.position.longitude}&'
        'key=AIzaSyCQc5pUr9CsqhIf0-Nb59EjXgkxmk9voSA';
    final response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'OK') {
      List points = data['routes'][0]['overview_polyline']['points'];
      List<LatLng> polylineCoordinates = _decodePolyline(points as String);

      setState(() {
        polyLines.add(Polyline(
          polylineId: const PolylineId('route'),
          points: polylineCoordinates,
          color: Colors.blue,
          width: 5,
        ));
      });
    }
  }
}
