import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';


class AppButton extends StatefulWidget {
  final String title;
  final String? icon;
  final bool selected;
  final bool enable;
  final double height;
  final VoidCallback onSubmit;
  final Color color;
  final Color colorBorder;
  final Color colorText;

  const AppButton({
    super.key,
    required this.title,
    required this.onSubmit,
    this.icon,
    this.selected = false,
    this.enable = true,
    this.height = SpacingUnit.x11,
    this.color = Colors.transparent,
    this.colorText = Colors.white,
    this.colorBorder = Colors.transparent
  });

  @override
  State<StatefulWidget> createState() => _AppButton();
}

class _AppButton extends State<AppButton> {
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
          border: Border.all(
            color: widget.colorBorder ,
            width: 1,
          ),
          color: widget.color == Colors.transparent ?widget.enable ? colors.primary : colors.surface5:widget.color,
        ),
        child: Center(
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
                color: widget.enable ? widget.colorText : colors.textTertiary,
                fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
