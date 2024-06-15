import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemButton extends StatelessWidget {
  const ItemButton({super.key, this.callbackSave, this.callbackCancel});

  final VoidCallback? callbackSave;
  final VoidCallback? callbackCancel;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Center(
      child: ElevatedButton(
        onPressed: () => _save(),
        style: ElevatedButton.styleFrom(
          backgroundColor: colors.blue,
        ),
        child: Text(
          appLocalizations.save,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x5,
          ),
        ),
      ),
    );
  }

  _save() {
    callbackSave?.call();
  }
}
