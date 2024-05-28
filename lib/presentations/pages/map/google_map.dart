import 'dart:async';

import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  GoogleMapController? mapController;

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  final Set<Marker> _markers = {};

  @override
  void initState() {
    _loadCustomMarker();
    super.initState();
  }


  Future<void> _loadCustomMarker() async {
    final BitmapDescriptor customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(48, 48)),
      Assets.images.icon.home.icBaselinePlace,
    );

    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId('customMarker'),
          position: const LatLng(21.002917, 105.865937),
          icon: customIcon,
          infoWindow: const InfoWindow(
            title: 'Custom Marker',
            snippet: 'This is a custom marker icon.',
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox(
          height: 500,
          width: 300,
          child: GoogleMap(
            onCameraMove: (CameraPosition cp) {
              //LatLng center = cp.target;
            },
            markers: _markers,
            mapType: MapType.normal,
            onTap: (position) => _setLatLng(position),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            initialCameraPosition: const CameraPosition(
              target: LatLng( 21.002917, 105.865937),
              zoom: 1,
            ),
            /*onMapCreated: (GoogleMapController controller) {
              mapController = controller;
            },*/
          ),
        ),
      ),
    );
  }

  _setLatLng(LatLng position) {

  }
}
