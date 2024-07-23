import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemActivateWidget extends StatefulWidget {
  const ItemActivateWidget({super.key, this.title = '', required this.callback});

  final String title;
  final VoidCallback callback;

  @override
  State<ItemActivateWidget> createState() => _ItemActivateWidgetState();
}

class _ItemActivateWidgetState extends State<ItemActivateWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: widget.callback,
      child: ContainerBorder(
        padding: SpacingUnit.x5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.text,
              size: SpacingUnit.x10,
            ),
          ],
        ),
      ),
    );
  }
}
