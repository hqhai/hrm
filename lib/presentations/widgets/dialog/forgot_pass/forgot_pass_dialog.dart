import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

forgotPassSuccess({required BuildContext context, required String email}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: ForgotPassSuccess(email: email),
      );
    },
  );
}

lockUpAccount({required BuildContext context, required String email}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: LockUpAccount(email: email),
      );
    },
  );
}

class ForgotPassSuccess extends StatelessWidget {
  const ForgotPassSuccess({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x8),
          child: Text(
            appLocalizations.forgotPasswordSuccess,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: SpacingUnit.x6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x8),
          child: Center(
            child: Image.asset(
              Assets.images.signIn.yes.path,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: SpacingUnit.x4,
            left: SpacingUnit.x4,
            bottom: SpacingUnit.x6,
          ),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: appLocalizations.newPasswordHasJustBeenSentToEmail,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                TextSpan(
                  text: ' $email ',
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: appLocalizations.pleaseCheckYourEmail,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LockUpAccount extends StatelessWidget {
  const LockUpAccount({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: SpacingUnit.x8),
          child: Text(
            appLocalizations.wrongPassword,
            style: const TextStyle(
              fontSize: SpacingUnit.x6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x8),
          child: Center(
            child: Image.asset(
              Assets.images.signIn.no.path,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.only(
              right: SpacingUnit.x4,
              left: SpacingUnit.x4,
              bottom: SpacingUnit.x6,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  appLocalizations.dialogWrongPasswordA,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
                const SizedBox(height: SpacingUnit.x8),
                Text(
                  appLocalizations.supportContact,
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: colors.text.withOpacity(0.4),
                    fontSize: SpacingUnit.x3,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
