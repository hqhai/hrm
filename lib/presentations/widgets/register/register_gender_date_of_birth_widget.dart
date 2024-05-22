import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class RegisterGenderEnumAndDateOfBirth extends StatefulWidget {
  final ValueChanged<bool> onChange;
  final ValueChanged<String> onChangeDateOfBirth;
  final ValueChanged<GenderEnum> onChangeGender;
  final String dateOfBirthDefault, genderDefault;

  const RegisterGenderEnumAndDateOfBirth(
      {super.key,
      required this.onChange,
      required this.onChangeGender,
      this.dateOfBirthDefault = '',
      this.genderDefault = '',
      required this.onChangeDateOfBirth});

  @override
  State<RegisterGenderEnumAndDateOfBirth> createState() =>
      _RegisterGenderEnumAndDateOfBirthState();
}

class _RegisterGenderEnumAndDateOfBirthState
    extends State<RegisterGenderEnumAndDateOfBirth> {
  late TextEditingController emailController;
  bool isCheckedInput = false;

  @override
  void initState() {
    super.initState();
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
        Text(appLocalizations.gender, style: TextStyle(fontSize: 28, color: colors.text)),
        const SizedBox(
          height: 29.5,
        ),
        BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return DropdownMenu<GenderEnum>(
              initialSelection: GenderEnum.male,
              onSelected: (GenderEnum? value) => widget.onChangeGender,
              dropdownMenuEntries:
                  GenderEnum.values.map((e) => e).map<DropdownMenuEntry<GenderEnum>>((GenderEnum value) {
                return DropdownMenuEntry<GenderEnum>(
                    value: value,
                    label: state.languageCode == LanguageEnum.en
                        ? value.nameEn
                        : value.nameVi);
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  bool checkInput(String emailController) {
    RegExp regExpEmail = RegExp(checkEmailRegexExp);
    return (regExpEmail.hasMatch(emailController))
        ? isCheckedInput = true
        : isCheckedInput = false;
  }
}
