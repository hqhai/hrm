import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class NoConnectionDialog extends StatelessWidget {
  const NoConnectionDialog({super.key});

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
            appLocalizations.noConnected,
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
            fit: BoxFit.fill,
            height: SpacingUnit.x20,
            width: SpacingUnit.x20,
          ),
        ],
      ),
    );
  }
}

dialogNoConnection({required BuildContext context}) {
  final colors = AppTheme.getColors(context);
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: colors.background,
        child: const NoConnectionDialog(),
      );
    },
  );
}
