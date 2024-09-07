import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemButton extends StatelessWidget {
  const ItemButton(
      {super.key, this.callbackSave, this.callbackCancel, this.id});
  final String? id;
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
              title: appLocalizations.cancelRequest,
              onSubmit: () => _cancel(),
              color: colors.blue.withOpacity(0.2),
              colorText: colors.primary,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x2),
            child: AppButton(
              title: id == null
                  ? appLocalizations.createRequest
                  : appLocalizations.saveRequest,
              enable: callbackSave != null,
              onSubmit: () => _save(),
              color: colors.primary,
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
