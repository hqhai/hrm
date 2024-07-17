import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class IconValueWidget extends StatelessWidget {
  const IconValueWidget({super.key, required this.icon, required this.value});
  final String icon, value;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x1_5),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: SvgPicture.asset(
                icon,
              colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
            ),
          ),
          Expanded(
            flex: 8,
            child: Text(
              value,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x3,
              ),
            ),
          )
        ],
      ),
    );
  }
}
