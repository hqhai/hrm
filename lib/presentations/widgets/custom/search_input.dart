import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({super.key, required this.onChange});

  final ValueChanged<String> onChange;

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: SpacingUnit.x3_5),
          child: Text(
            appLocalizations.search,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x4,
            ),
          ),
        ),
        SizedBox(
          width: width * 0.6,
          child: TextField(
            controller: searchController,
            style: TextStyle(color: colors.text, fontSize: SpacingUnit.x3_5),
            onChanged: (value) => _setOnChange(value),
            decoration: InputDecoration(

              labelText: appLocalizations.search,
              contentPadding: const EdgeInsets.only(
                  bottom: 0,
                  left: SpacingUnit.x4,
                  top: SpacingUnit.x2_5,
                  right: SpacingUnit.x4 // HERE THE IMPORTANT PART
                  ),
              suffixIcon: IconButton(
                onPressed: () => _setOnClick(),
                icon: Icon(
                  Icons.search,
                  color: colors.textTertiary,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x2),
                borderSide: BorderSide(
                  color: colors.outline,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x2),
                borderSide: BorderSide(
                  color: colors.primary,
                  width: 1.0,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(SpacingUnit.x2),
                borderSide: BorderSide(
                  color: colors.outline,
                  width: 1.0,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  _setOnChange(String value) {
    widget.onChange(value);
  }

  _setOnClick() {
    widget.onChange(searchController.text);
  }
}
