/*import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    super.key,
    this.latLng,
    this.markers = const {},
    this.locationSchool = const LatLng(21.003016, 105.861669),
  });

  final LatLng? latLng;
  final Set<Marker> markers;
  final LatLng locationSchool;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  late GoogleMapController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: SpacingUnit.x15,
        ),
        SizedBox(
          height: width * 0.6,
          width: width,
          child: GoogleMap(
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) => setCamera(controller),
            markers: widget.markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: widget.latLng ?? widget.locationSchool,
              zoom: 15,
            ),
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x15,
        ),
      ],
    );
  }


}*/
