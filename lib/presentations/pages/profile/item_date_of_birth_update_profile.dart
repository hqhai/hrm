import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemDateOfBirthUpdateProfile extends StatefulWidget {
  const ItemDateOfBirthUpdateProfile({
    super.key,
    this.dateOfBirth = '',
    required this.onChangeDateOfBirth,
  });


  final ValueChanged<String> onChangeDateOfBirth;

  final String dateOfBirth;

  @override
  State<ItemDateOfBirthUpdateProfile> createState() =>
      _ItemDateOfBirthUpdateProfileState();
}

class _ItemDateOfBirthUpdateProfileState extends State<ItemDateOfBirthUpdateProfile> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              appLocalizations.dateOfBirth,
              style: TextStyle(color: colors.tertiary, fontSize: SpacingUnit.x4),
            ),
            const SizedBox(height: SpacingUnit.x3,),
            DatePicker(
              check: false,
              onChange: (value) => widget.onChangeDateOfBirth,
              oldDate: widget.dateOfBirth,
            ),
            const SizedBox(height: SpacingUnit.x3,),
          ],
        ),
        const SizedBox(
          height: SpacingUnit.x2,
        ),
      ],
    );
  }
}
