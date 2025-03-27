import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/gen/assets.gen.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:base_app/presentations/bloc/language/language_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class LanguageWidget extends StatefulWidget {
  const LanguageWidget({
    super.key,
  });

  @override
  State<LanguageWidget> createState() => _LanguageWidgetState();
}

class _LanguageWidgetState extends State<LanguageWidget> {
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
    return Align(
      alignment: Alignment.topRight,
      child: BlocBuilder<LanguageCubit, LanguageState>(
        builder: (context, state) {
          return InkWell(
            onTap: () => _language(context, state),
            child: Container(
              width: SpacingUnit.x20,
              margin: const EdgeInsets.only(top: SpacingUnit.x4),
              padding: const EdgeInsets.all(SpacingUnit.x2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SpacingUnit.x2),
                color: colors.background,
                border: Border.all(
                  color: colors.text.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    state.languageCode.name,
                    style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x4,
                    ),
                  ),
                  const SizedBox(
                    width: SpacingUnit.x0_5,
                  ),
                  Image.asset(
                    state.languageCode == LanguageEnum.vi
                        ? Assets.images.signIn.vn.path
                        : Assets.images.signIn.eng.path,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          );
        },
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
