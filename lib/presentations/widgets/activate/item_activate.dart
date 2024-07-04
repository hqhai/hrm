import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemActivateWidget extends StatefulWidget {
  const ItemActivateWidget({super.key, this.title = '', this.iconPath, required this.callback});

  final String? iconPath;
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
        height: SpacingUnit.x20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_check())
              Expanded(
                flex: 15,
                child: Padding(
                  padding: const EdgeInsets.only(right: SpacingUnit.x5),
                  child: SvgPicture.asset(
                    fit: BoxFit.fill,
                    widget.iconPath ?? "",height: SpacingUnit.x20,
                    colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                  ),
                ),
              ),
            Expanded(
              flex: 75,
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: colors.text, fontSize: SpacingUnit.x5),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _check() {
    return widget.iconPath?.isNotEmpty ?? false;
  }
}
