import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class NoConnectionDialog extends StatelessWidget {
  final String error;

  const NoConnectionDialog({
    super.key,
    this.error = '',
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            error.isEmpty ? appLocalizations.noConnected : error,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: SpacingUnit.x4,
              color: colors.error,
            ),
          ),
          const SizedBox(
            height: SpacingUnit.x4,
          ),
          Image.asset(
            Assets.images.timeKeeping.fail.path,
            height: SpacingUnit.x15,
            width: SpacingUnit.x15,
          ),
        ],
      ),
    );
  }
}

dialogNoConnection({
  required BuildContext context,
  String error = '',
}) {
  final colors = AppTheme.getColors(context);
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: colors.background,
        child: NoConnectionDialog(
          error: error,
        ),
      );
    },
  );
}
