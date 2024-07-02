
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatefulWidget {
  const GoogleMapWidget({
    super.key,
    this.latLng = const LatLng(0, 0),
    this.markers = const {},
  });

  final LatLng latLng;
  final Set<Marker> markers;

  @override
  State<GoogleMapWidget> createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
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
            onMapCreated: (GoogleMapController controller) {
              controller.moveCamera(CameraUpdate.newLatLng(widget.latLng));
            },
            markers: widget.markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: widget.latLng,
              zoom: 1,
            ),
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x15,
        ),
      ],
    );
  }
}
