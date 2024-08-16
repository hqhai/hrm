import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class LocationOverTime extends StatelessWidget {
  const LocationOverTime({super.key, this.isCheck, required this.change});

  final bool? isCheck;
  final ValueChanged<bool> change;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: SpacingUnit.x2,
        ),
        TitleRequired(
          title: appLocalizations.destinationOT,
          requiredValidate: true,
        ),
        ContainerBorder(
          paddingVertical: 0,
          borderColors: colors.text.withOpacity(0.4),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              appLocalizations.inCompany,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
            leading: Radio<bool>(
              value: true,
              groupValue: isCheck,
              onChanged: (value) => _setLocation(value),
            ),
          ),
        ),
        ContainerBorder(
          paddingVertical: 0,
          borderColors: colors.text.withOpacity(0.4),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Row(
              children: [
                Text(
                  appLocalizations.outCompany,
                  style: TextStyle(
                    color: colors.text,
                    fontSize: SpacingUnit.x4,
                  ),
                ),
              ],
            ),
            leading: Radio<bool>(
              value: false,
              groupValue: isCheck,
              onChanged: (value) => _setLocation(value),
            ),
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4,
        ),
      ],
    );
  }

  _setLocation(bool? value) {
    change.call(value ?? true);
  }
}
