import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_input_email.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class RegisterEmail extends StatefulWidget {
  final ValueChanged<bool> onChange;
  final ValueChanged<String> onChangeEmail;
  final String emailDefault;

  const RegisterEmail(
      {super.key, required this.onChange, required this.onChangeEmail, this.emailDefault = ''});

  @override
  State<RegisterEmail> createState() => _RegisterEmailState();
}

class _RegisterEmailState extends State<RegisterEmail> {
  late TextEditingController emailController;
  bool isCheckedInput = false;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController(text: widget.emailDefault);
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
        Text(appLocalizations.whatIsYourEmail, style: TextStyle(fontSize: 28, color: colors.text)),
        const SizedBox(
          height: 29.5,
        ),
        AppInputEmail(
            placeHolder: appLocalizations.email,
            controller: emailController,
            onChange: (value) => {
              widget.onChange.call(checkInput(value)),
              widget.onChangeEmail.call(emailController.text)
            }),
      ],
    );
  }

  bool checkInput(String emailController) {
    RegExp regExpEmail = RegExp(checkEmailRegexExp);
    return (regExpEmail.hasMatch(emailController)) ? isCheckedInput = true : isCheckedInput = false;
  }
}