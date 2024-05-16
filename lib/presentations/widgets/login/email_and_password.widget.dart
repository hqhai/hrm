import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:base_app/presentations/widgets/custom/app_input_password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      children: [
        const SizedBox(height: SpacingUnit.x5),
        AppInputEmail(
          iconLeft: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x2_5),
            child: SvgPicture.asset(
              Assets.images.icon.person,
              colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
            ),
          ),
          placeHolder: appLocalizations.email,
          error: widget.errorEmail,
          controller: widget.emailController,
          onChange: widget.onChangeEmail,
        ),
        const SizedBox(height: SpacingUnit.x4),
        AppInputPassword(
          iconLeft: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x2_5),
            child: SvgPicture.asset(
              Assets.images.icon.lock,
              colorFilter: ColorFilter.mode(colors.outline, BlendMode.srcIn),
            ),
          ),
          error: widget.errorPass,
          placeHolder: appLocalizations.password,
          controller: widget.passwordController,
          onChange: widget.onChangePass,
        ),
        const SizedBox(height: SpacingUnit.x4),
      ],
    );
  }
}
