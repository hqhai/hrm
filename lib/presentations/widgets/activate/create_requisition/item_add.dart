import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:themes/themes.dart';

class ItemAdd extends StatelessWidget {
  const ItemAdd(
      {super.key,
      this.errorProduct = '',
      this.title = '',
      required this.callback,
      this.checkTypeContainer = true});

  final String errorProduct, title;
  final VoidCallback callback;
  final bool checkTypeContainer;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TitleRequired(title: title, requiredValidate: true),
              InkWell(
                onTap: () => callback.call(),
                child: SizedBox(
                  width: SpacingUnit.x8,
                  height: SpacingUnit.x8,
                  child: SvgPicture.asset(
                    width: SpacingUnit.x8,
                    height: SpacingUnit.x8,
                    checkTypeContainer
                        ? Assets.images.icon.home.chevronForward
                        : Assets.images.icon.activateIcon.drop,
                    colorFilter: ColorFilter.mode(colors.text.withOpacity(0.4), BlendMode.srcIn),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorProduct.isNotEmpty)
          Text(
            errorProduct,
            style: TextStyle(
              color: colors.error,
              fontSize: SpacingUnit.x3,
            ),
          ),
      ],
    );
  }
}
