import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class SaveForgotPass extends StatelessWidget {
  const SaveForgotPass({
    super.key,
    required this.callback,
    required this.setCheck,
    required this.check,
  });

  final VoidCallback callback;
  final ValueChanged<bool?> setCheck;
  final bool check;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppCheckbox(
            onChanged: (bool? value) => setCheck.call(value),
            label: appLocalizations.staySignedIn,
            value: check,
            color: colors.text,
            checkColor: Colors.white),
        InkWell(
          onTap: callback.call,
          child: Text(appLocalizations.forgotPassword,
              style: TextStyle(
                fontSize: SpacingUnit.x3_5,
                color: colors.text.withValues(alpha: 0.5),
              )),
        ),
      ],
    );
  }
}
