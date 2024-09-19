import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/regex_exp.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/pages/profile/item_gender_update_profile.dart';
import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  State<RegisterGenderEnumAndDateOfBirth> createState() => _RegisterGenderEnumAndDateOfBirthState();
}

class _RegisterGenderEnumAndDateOfBirthState extends State<RegisterGenderEnumAndDateOfBirth> {
  late TextEditingController emailController;
  bool isCheckedInput = false;
  String gender = GenderEnum.male.name, dateOfBirth = '';
  final DateTime now = DateTime.now();

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: SpacingUnit.x7,
        ),
        const SizedBox(
          height: SpacingUnit.x7,
        ),
        ItemGenderUpdateProfile(
            onChangeGender: (value) => _setGender(value), gender: GenderEnum.male),
        const SizedBox(
          height: SpacingUnit.x7,
        ),
        Text(appLocalizations.dateOfBirth,
            style: TextStyle(
                fontSize: SpacingUnit.x4, color: colors.text, fontWeight: FontWeight.w600)),
        DatePickerLoop(
          onChange: (value) => _setDateOfBirth(value),
          oldDate: time(),
        )
      ],
    );
  }

  DateTime time() {
    if (dateOfBirth.isNotEmpty) {
      final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
      return dateFormat.parse(dateOfBirth);
    }
    return now;
  }

  bool checkInput(String emailController) {
    RegExp regExpEmail = RegExp(checkEmailRegexExp);
    return (regExpEmail.hasMatch(emailController)) ? isCheckedInput = true : isCheckedInput = false;
  }

  _setGender(GenderEnum? value) {
    widget.onChangeGender.call(value ?? GenderEnum.male);
    setState(() {
      gender = value?.name ?? "";
    });
    _check();
  }

  _setDateOfBirth(DateTime value) {
    widget.onChangeDateOfBirth.call(formatYMD(value.toString()));
    setState(() {
      dateOfBirth = formatYMD(value.toString());
    });
    _check();
  }

  _check() {
    if (gender != '' && dateOfBirth != '') {
      widget.onChange.call(true);
    }
  }
}
