import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemButtonListStationery extends StatelessWidget {
  const ItemButtonListStationery({super.key, this.callbackAdd, this.callbackCancel});

  final VoidCallback? callbackAdd;
  final VoidCallback? callbackCancel;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () => _add(),
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
        ElevatedButton(
          onPressed: () => _cancel(),
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.blue,
          ),
          child: Text(
            appLocalizations.cancel,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x5,
            ),
          ),
        ),
      ],
    );
  }

  _add() {
    callbackAdd?.call();
  }

  _cancel() {
    callbackCancel?.call();
  }
}
