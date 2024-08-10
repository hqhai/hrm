import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
            child: AppButton(
              title: appLocalizations.cancel,
              onSubmit: () => _cancel(),
              color: colors.outline.withOpacity(0.2),
              colorText: colors.text,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
            child: AppButton(
              title: appLocalizations.save,
              onSubmit: () => _save(),
              color: colors.blue,
              colorText: colors.background,
            ),
          ),
        ),
      ],
    );
  }

  _save() {
    callbackSave?.call();
  }

  _cancel() {
    callbackCancel?.call();
  }
}
