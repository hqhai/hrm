import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget({
    super.key,
  });


  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {
  LanguageEnum getDropdownLanguageValue(LanguageEnum? languageCode) {
    if (languageCode == LanguageEnum.en) {
      return LanguageEnum.en;
    } else {
      return LanguageEnum.vi;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.only(top: SpacingUnit.x10, right: SpacingUnit.x4),
      child: Align(
        alignment: Alignment.topRight,
        child: BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return InkWell(
              onTap: () => _language(context, state),
              child: Container(
                padding: const EdgeInsetsDirectional.all(SpacingUnit.x4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SpacingUnit.x0_5),
                  border: Border.all(
                    color: colors.background,
                    width: 1,
                  ),
                ),
                child: Text(
                  state.languageCode.name,
                  style: TextStyle(
                    color: colors.background,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _language(BuildContext context, LanguageState state) {
    if (state.languageCode == LanguageEnum.en) {
      dI<LanguageCubit>().changeLocale(LanguageEnum.vi);
    } else {
      dI<LanguageCubit>().changeLocale(LanguageEnum.en);
    }
  }
}
