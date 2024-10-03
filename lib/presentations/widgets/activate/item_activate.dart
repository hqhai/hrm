import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemActivateWidget extends StatefulWidget {
  const ItemActivateWidget(
      {super.key,
      this.title = '',
      required this.callback,
      this.color = Colors.white,
      this.padding = SpacingUnit.x2,
      this.paddingVertical = SpacingUnit.x2});

  final String title;
  final VoidCallback callback;
  final Color color;
  final double padding;
  final double paddingVertical;

  @override
  State<ItemActivateWidget> createState() => _ItemActivateWidgetState();
}

class _ItemActivateWidgetState extends State<ItemActivateWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: widget.callback,
      child: ContainerBorder(
        backgroundColors: widget.color,
        borderColors: widget.color,
        width: width,
        paddingVertical: widget.paddingVertical,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: EdgeInsets.all(widget.padding),
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Icon(
              Icons.chevron_right_outlined,
              color: colors.text,
              size: SpacingUnit.x6,
            ),
          ],
        ),
      ),
    );
  }
}
