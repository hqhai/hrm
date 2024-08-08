import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIconStatus extends StatelessWidget {
  const AppIconStatus({super.key, required this.icon, required this.status, required this.color});

  final String icon, status;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x0_5),
          child: SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        Text(
          status,
          style: TextStyle(
            color:color,
            fontSize: SpacingUnit.x3_5,
          ),
        ),
      ],
    );
  }
}
