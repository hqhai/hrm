import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  final double? height;
  final Color? color;
  const LineWidget({super.key, this.height = 0.5, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: height,
      color: color,
    );
  }
}
