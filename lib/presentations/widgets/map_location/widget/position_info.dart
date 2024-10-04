import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:themes/themes.dart';

class PositionInfo extends StatelessWidget {
  final Marker marker;
  final VoidCallback onClose;
  final ValueChanged<Marker> gotoLocation;

  const PositionInfo(
      {super.key,
      required this.marker,
      required this.gotoLocation,
      required this.onClose});

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(SpacingUnit.x2_5),
            topRight: Radius.circular(SpacingUnit.x2_5)),
      ),
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                onPressed: () => onClose.call(),
                icon: Icon(
                  Icons.cancel_outlined,
                  color: colors.text,
                )),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  marker.infoWindow.title ?? '',
                  style: theme.textTheme.titleSmall?.copyWith(
                      color: colors.text,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: SpacingUnit.x2_5,
                ),
                Text(_getSubText(),
                    style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600, color: colors.text)),
                Image.asset(
                  _getIMG(),
                  fit: BoxFit.contain,
                  width: MediaQuery.of(context).size.width - 100,
                  height: MediaQuery.of(context).size.height / 3,
                ),

                ///ToDO: sau mo quyen API thi chi duong
                // Padding(
                //   padding: const EdgeInsetsDirectional.symmetric(
                //       horizontal: SpacingUnit.x10),
                //   child: AppButton(
                //     colorText: Colors.white,
                //     title: 'Đường đi',
                //     onSubmit: () => gotoLocation.call(marker),
                //   ),
                // )
              ],
            ),
          ))
        ],
      ),
    );
  }

  String _getSubText() {
    switch (marker.markerId.toString()) {
      case 'MarkerId(0 Ids)':
        return 'Địa chỉ: 33 Phố Lạc Trung, Quận Hai Bà Trưng, Hà Nội \nTel: 19000033 | HotLine: 0904216513 \nMail: info@atlantic.edu.vn';
      case 'MarkerId(1 Ids)':
        return 'Địa chỉ: 35 Phố Lạc Trung, Quận Hai Bà Trưng, Hà Nội \nTel: 19000033 | HotLine: 0904216513 \nMail: fsel@atlantic.edu.vn';
      case 'MarkerId(2 Ids)':
        return 'Địa chỉ: 125 Hoàng Ngân, Hà Nội \nTel: 024 7108 0033 | Hotline: : 0936.338.656/0934.630.885 \nMail: cso-hoangngan@atlantic.edu.vn';
    }
    return '';
  }

  String _getIMG() {
    switch (marker.markerId.toString()) {
      case 'MarkerId(0 Ids)':
        return Assets.images.icon.imgLacTrung.path;
      case 'MarkerId(1 Ids)':
        return Assets.images.icon.imgFsel.path;
      case 'MarkerId(2 Ids)':
        return Assets.images.icon.imgHoangNgan.path;
    }
    return '';
  }
}
