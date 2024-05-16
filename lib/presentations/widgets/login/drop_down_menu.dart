import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class DropdownMenuWidget extends StatefulWidget {
  const DropdownMenuWidget(
      {super.key, this.onSelected,});

  final ValueChanged<String?>? onSelected;

  @override
  State<DropdownMenuWidget> createState() => _DropdownMenuWidgetState();
}

class _DropdownMenuWidgetState extends State<DropdownMenuWidget> {

  String getDropdownLanguageValue(String? languageCode) {
    if (languageCode == LanguageCodeEnum.en.name) {
      return LanguageEnum.en.name;
    } else {
      return LanguageEnum.vi.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    return Padding(
      padding: const EdgeInsets.only(top: SpacingUnit.x10, right: SpacingUnit.x4),
      child: Align(
        alignment: Alignment.topRight,
        child: BlocBuilder<LanguageCubit, LanguageCodeEnum>(
          builder: (context, languageCode) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SpacingUnit.x0_5),
                border: Border.all(
                  color: colors.outline,
                  width: 1,
                ),
              ),
              child: DropdownMenu<String>(
                width: SpacingUnit.x34,
                textStyle: TextStyle(color: colors.text, fontSize: SpacingUnit.x3),
                initialSelection: getDropdownLanguageValue(languageCode.name),
                onSelected: widget.onSelected,
                dropdownMenuEntries: LanguageEnum.values
                    .map((e) => e.name)
                    .map<DropdownMenuEntry<String>>((String value) {
                  return DropdownMenuEntry<String>(value: value, label: value);
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
