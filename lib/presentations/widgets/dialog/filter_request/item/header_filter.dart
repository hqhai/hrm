import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class HeaderFilter extends StatelessWidget {
  const HeaderFilter({super.key, required this.callback, this.title});

  final VoidCallback callback;
  final String? title;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => callback.call(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: SpacingUnit.x2_5,
              vertical: SpacingUnit.x4,
            ),
            child: Icon(
              Icons.close,
              size: SpacingUnit.x8,
              color: colors.text,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2_5),
          child: Text(
            title ?? appLocalizations.filter,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: SpacingUnit.x6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: SpacingUnit.x13),
      ],
    );
  }
}
