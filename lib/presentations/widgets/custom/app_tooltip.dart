import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class AppTooltip extends StatefulWidget {
  const AppTooltip({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  final GlobalKey<TooltipState> tooltipKey = GlobalKey<TooltipState>();

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Tooltip(
      key: tooltipKey,
      decoration: BoxDecoration(
        color: colors.text.withValues(alpha: 0.1),
        borderRadius: const BorderRadius.all(Radius.circular(SpacingUnit.x4)),
      ),
      verticalOffset: -SpacingUnit.x12,
      textStyle: TextStyle(color: colors.text, fontSize: SpacingUnit.x4),
      message: widget.title,
      triggerMode: TooltipTriggerMode.manual,
      child: InkWell(
        onTap: () => _onClick(),
        child: SvgPicture.asset(
          height: SpacingUnit.x6,
          width: SpacingUnit.x16,
          Assets.images.icon.activateIcon.information,
          colorFilter: ColorFilter.mode(
            colors.text.withValues(alpha: 0.5),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  _onClick() {
    tooltipKey.currentState?.ensureTooltipVisible();
  }
}
