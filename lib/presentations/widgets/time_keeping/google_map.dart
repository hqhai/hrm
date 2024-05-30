import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';

class GoogleMapWidget extends StatelessWidget {
  const GoogleMapWidget({super.key, this.latLng = const LatLng(0,0), this.markers = const {}});
  final LatLng latLng;
  final Set<Marker> markers;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: SpacingUnit.x15,
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
            markers: markers,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: latLng,
              zoom: 18,
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
