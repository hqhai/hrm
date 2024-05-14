import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/register/app_input_new_pssword_validate.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input_password.dart';

class RegisterPassword extends StatefulWidget {
  final ValueChanged<bool> onChange;
  final ValueChanged<String> onChangePassword;
  final String passwordDefault;

  const RegisterPassword(
      {super.key,
      required this.onChange,
      required this.onChangePassword,
      this.passwordDefault = ''});

  @override
  State<RegisterPassword> createState() => _RegisterPasswordState();
}

class _RegisterPasswordState extends State<RegisterPassword> {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  bool isCheckedInput = false;
  int condition = 0, condition_1 = 0, condition_2 = 0, condition_3 = 0, condition_4 = 0;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController(text: widget.passwordDefault);
    confirmPasswordController = TextEditingController(text: widget.passwordDefault);
    progress();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(
          height: 29.5,
        ),
        Text(appLocalizations.chooseAPassword, style: TextStyle(fontSize: 28, color: colors.text)),
        const SizedBox(
          height: 29.5,
        ),
        AppInputPassword(
          placeHolder: appLocalizations.password,
          controller: passwordController,
          onChange: (value) {
            setState(() {
              passwordController.text = value;
              progress();
            });
          },
        ),
        if (passwordController.text != '')
          AppInputNewPasswordValidate(password: passwordController.text, condition: condition),
        const SizedBox(
          height: 29.5,
        ),
        AppInputPassword(
            placeHolder: appLocalizations.confirmPassword,
            controller: confirmPasswordController,
            onChange: (value) => {
                  widget.onChange.call(checkInput(passwordController.text)),
                  widget.onChangePassword.call(passwordController.text)
                }),
      ],
    );
  }

  bool checkInput(String passwordController) {
    RegExp regExpPass = RegExp(checkPasswordRegexExp);
    return (regExpPass.hasMatch(passwordController))
        ? isCheckedInput = true
        : isCheckedInput = false;
  }

  void progress() {
    RegExp(r'^.{9,}$').hasMatch(passwordController.text) ? condition_1 = 1 : condition_1 = 0;
    RegExp(r'.*[0-9]+.*').hasMatch(passwordController.text) ? condition_2 = 1 : condition_2 = 0;
    RegExp(r'.*[A-Z]+.*').hasMatch(passwordController.text) ? condition_3 = 1 : condition_3 = 0;
    RegExp(r'.*[\W_]+.*').hasMatch(passwordController.text) ? condition_4 = 1 : condition_4 = 0;
    condition = condition_1 + condition_2 + condition_3 + condition_4;
  }
}
