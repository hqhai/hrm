import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemGenderUpdateProfile extends StatefulWidget {
  const ItemGenderUpdateProfile({
    super.key,
    this.gender = GenderEnum.male,
    required this.onChangeGender,
  });

  final ValueChanged<GenderEnum> onChangeGender;
  final GenderEnum gender;

  @override
  State<ItemGenderUpdateProfile> createState() =>
      _ItemGenderUpdateProfileState();
}

class _ItemGenderUpdateProfileState extends State<ItemGenderUpdateProfile> {
  @override
  void initState() {
    super.initState();
  }

  GenderEnum convertGenderEnum() {
    if (widget.gender == GenderEnum.male) {
      return GenderEnum.male;
    } else if (widget.gender == GenderEnum.female) {
      return GenderEnum.female;
    } else {
      return GenderEnum.other;
    }
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.gender,
              style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
            DropdownMenu<GenderEnum>(
              textStyle: const TextStyle(fontSize: SpacingUnit.x3),
              initialSelection: convertGenderEnum(),
              onSelected: (GenderEnum? value) => _setGender(value),
              dropdownMenuEntries:
                  GenderEnum.values.map<DropdownMenuEntry<GenderEnum>>((GenderEnum value) {
                return DropdownMenuEntry<GenderEnum>(
                    value: value,
                    label: value.configGenderName);
              }).toList(),
            ),
            const SizedBox(
              height: SpacingUnit.x3,
            ),
          ],
        );
      },
    );
  }

  _setGender(GenderEnum? value) {
    widget.onChangeGender.call(value??GenderEnum.male);
  }
}
