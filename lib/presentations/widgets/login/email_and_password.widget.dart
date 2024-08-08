import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:base_app/presentations/widgets/custom/app_input_password.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class EmailAndPasswordWidget extends StatefulWidget {
  const EmailAndPasswordWidget(
      {super.key,
      this.emailController,
      this.passwordController,
      this.errorEmail,
      this.errorPass,
      this.onChangeEmail,
      this.onChangePass});

  final TextEditingController? emailController, passwordController;
  final String? errorEmail, errorPass;
  final ValueChanged<String>? onChangeEmail, onChangePass;

  @override
  State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.username,
          style:
              TextStyle(color: colors.text, fontSize: SpacingUnit.x4, fontWeight: FontWeight.w600),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: SpacingUnit.x4,
            top: SpacingUnit.x2,
          ),
          child: AppInputEmail(
            placeHolder: appLocalizations.username,
            error: widget.errorEmail,
            controller: widget.emailController,
            onChange: widget.onChangeEmail,
          ),
        ),
        Text(
          appLocalizations.password,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: SpacingUnit.x2,
            top: SpacingUnit.x2,
          ),
          child: AppInputPassword(
            error: widget.errorPass,
            placeHolder: appLocalizations.password,
            controller: widget.passwordController,
            onChange: widget.onChangePass,
          ),
        ),
        const SizedBox(height: SpacingUnit.x4),
      ],
    );
  }
}
