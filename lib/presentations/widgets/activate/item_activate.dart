import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
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
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.callback,
      child: Container(
        height: SpacingUnit.x20,
        margin: const EdgeInsets.symmetric(vertical: SpacingUnit.x3),
        padding: const EdgeInsets.all(SpacingUnit.x3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SpacingUnit.x2),
          color: CustomsColor.colorBackground,
          border: Border.all(
            color: colors.text,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            if (_check())
              Padding(
                padding: const EdgeInsets.only(right: SpacingUnit.x5),
                child: SvgPicture.asset(
                  widget.iconPath ?? "",
                  colorFilter: ColorFilter.mode(colors.text, BlendMode.srcIn),
                ),
              ),
            SizedBox(
              width: _check() ? width* 0.6 : width* 0.75,
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

  bool _check(){
    return widget.iconPath?.isNotEmpty ?? false;
  }
}
