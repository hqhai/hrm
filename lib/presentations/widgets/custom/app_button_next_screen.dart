import 'package:base_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';
import 'package:common/utils/spacing_unit.dart';

class AppButtonNextScreen extends StatefulWidget {
  final String title;
  final String? icon;
  final bool selected;
  final bool enable;
  final double height;
  final VoidCallback onSubmit;
  final Color color;
  final Color colorText;

  const AppButtonNextScreen({
    super.key,
    required this.title,
    required this.onSubmit,
    this.icon,
    this.selected = false,
    this.enable = true,
    this.height = SpacingUnit.x11,
    this.color = Colors.transparent,
    this.colorText = Colors.white,
  });

  @override
  State<StatefulWidget> createState() => _AppButtonNextScreen();
}

class _AppButtonNextScreen extends State<AppButtonNextScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = AppTheme.getColors(context);

    return InkWell(
      onTap: () {
        if (widget.enable == true) widget.onSubmit();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
          color: widget.color == Colors.transparent
              ? widget.enable
                  ? colors.primary
                  : colors.surface5
              : widget.color,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: widget.colorText, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                width: SpacingUnit.x2,
              ),
              SvgPicture.asset(
                height: SpacingUnit.x4,
                Assets.images.icon.home.worksheet.arrowRight,
                colorFilter: ColorFilter.mode(widget.colorText, BlendMode.srcIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
