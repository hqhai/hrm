import 'package:flutter/cupertino.dart';

class ColorUtils {
  static Color shiftHsl(Color c, [double amt = 0]) {
    HSLColor hslColor = HSLColor.fromColor(c);
    return hslColor
        .withLightness((hslColor.lightness + amt).clamp(0.0, 1.0).toDouble())
        .toColor();
  }

  static Color parseHex(String value) =>
      Color(int.parse(value.substring(1, 7), radix: 16) + 0xFF000000);

  static Color blend(Color dst, Color src, double opacity) {
    return Color.fromARGB(
      255,
      (dst.r.toDouble() * (1.0 - opacity) + src.r.toDouble() * opacity).toInt(),
      (dst.g.toDouble() * (1.0 - opacity) + src.g.toDouble() * opacity).toInt(),
      (dst.b.toDouble() * (1.0 - opacity) + src.b.toDouble() * opacity).toInt(),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    var hexColorConverted = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColorConverted.length == 6) {
      hexColorConverted = 'FF$hexColorConverted';
    }
    return int.parse(hexColorConverted, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
