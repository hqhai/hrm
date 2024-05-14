import 'package:base_app/common/utils/map_item_custom.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:themes/themes.dart';

class AppInputNewPasswordValidate extends StatefulWidget {
  final String password;
  final int condition;

  const AppInputNewPasswordValidate({super.key, this.password = '', this.condition = 0});

  @override
  State<AppInputNewPasswordValidate> createState() => _AppInputNewPasswordValidateState();
}

class _AppInputNewPasswordValidateState extends State<AppInputNewPasswordValidate> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final color = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSize(
              alignment: Alignment.centerLeft,
              curve: Curves.easeIn,
              reverseDuration: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: 5,
                width: width * 0.55 * values[widget.condition],
                color: colors[widget.condition],
              ),
            ),
            Text(
              levels(context)[widget.condition],
              style: TextStyle(
                fontSize: 14,
                color: colors[widget.condition],
              ),
            )
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
                RegExp(r'^.{9,}$').hasMatch(widget.password)
                    ? Assets.images.icon.check
                    : Assets.images.icon.closeSquare,
                height: 24,
                width: 24),
            const SizedBox(
              width: 8,
            ),
            Text(
              appLocalizations.atLeastEightCharacters,
              style: TextStyle(
                fontSize: 14,
                color: RegExp(r'^.{9,}$').hasMatch(widget.password)
                    ? color.text
                    : color.textTertiary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
                RegExp(r'.*[0-9]+.*').hasMatch(widget.password)
                    ? Assets.images.icon.check
                    : Assets.images.icon.closeSquare,
                height: 24,
                width: 24),
            const SizedBox(
              width: 8,
            ),
            Text(
              appLocalizations.containsANumber,
              style: TextStyle(
                fontSize: 14,
                color: RegExp(r'.*[0-9]+.*').hasMatch(widget.password)
                    ? color.text
                    : color.textTertiary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
                RegExp(r'.*[A-Z]+.*').hasMatch(widget.password)
                    ? Assets.images.icon.check
                    : Assets.images.icon.closeSquare,
                height: 24,
                width: 24),
            const SizedBox(
              width: 8,
            ),
            Text(
              appLocalizations.containsACapitalLetter,
              style: TextStyle(
                fontSize: 14,
                color: RegExp(r'.*[A-Z]+.*').hasMatch(widget.password)
                    ? color.text
                    : color.textTertiary,
              ),
            ),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
                RegExp(r'.*[\W_]+.*').hasMatch(widget.password)
                    ? Assets.images.icon.check
                    : Assets.images.icon.closeSquare,
                height: 24,
                width: 24),
            const SizedBox(
              width: 8,
            ),
            Text(
              appLocalizations.containsASymbol,
              style: TextStyle(
                fontSize: 14,
                color: RegExp(r'.*[\W_]+.*').hasMatch(widget.password)
                    ? color.text
                    : color.textTertiary,
              ),
            ),
          ],
        )
      ],
    );
  }
}
