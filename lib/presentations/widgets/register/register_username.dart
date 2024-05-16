import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_input.dart';

class RegisterUsername extends StatefulWidget {
  final ValueChanged<bool> onChange;
  final ValueChanged<String> onChangeFirstName;
  final ValueChanged<String> onChangeLastName;
  final String firstNameDefault, lastNameDefault;

  const RegisterUsername(
      {super.key,
        required this.onChange,
        required this.onChangeFirstName,
        required this.onChangeLastName,
        this.firstNameDefault = '',
        this.lastNameDefault = ''});

  @override
  State<RegisterUsername> createState() => _RegisterUsernameState();
}

class _RegisterUsernameState extends State<RegisterUsername> {
  late TextEditingController lastNameController;
  late TextEditingController firstNameController;
  bool isCheckedInput = false;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.firstNameDefault);
    lastNameController = TextEditingController(text: widget.lastNameDefault);
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
        Text(appLocalizations.chooseAUsername, style: TextStyle(fontSize: 28, color: colors.text)),
        const SizedBox(
          height: 29.5,
        ),
        AppInput(
            placeHolder: appLocalizations.firstName,
            controller: firstNameController,
            onChange: (value) => {
              widget.onChange.call(checkInput(firstNameController.text)),
              widget.onChangeFirstName.call(firstNameController.text),
            }),
        const SizedBox(
          height: 29.5,
        ),
        AppInput(
            placeHolder: appLocalizations.lastName,
            controller: lastNameController,
            onChange: (value) => {
              widget.onChange.call(checkInput(lastNameController.text)),
              widget.onChangeLastName.call(lastNameController.text),
            }),
      ],
    );
  }

  bool checkInput(String usernameController) {
    return (usernameController != '') ? isCheckedInput = true : isCheckedInput = false;
  }
}
