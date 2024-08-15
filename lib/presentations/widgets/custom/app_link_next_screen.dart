import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class AppLinkNextScreen extends StatelessWidget {
  const AppLinkNextScreen({super.key, required this.callback});
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return GestureDetector(
      onTap: () => callback.call(),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3,),
            child: Text(
              appLocalizations.seeDetails,
              style: TextStyle(
                color: colors.primary,
                fontSize: SpacingUnit.x3_5,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: colors.primary,
            size: SpacingUnit.x4_5,
          ),
        ],
      ),
    );
  }
}
