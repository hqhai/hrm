import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/widgets/custom/date_picker_cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemDateOfBirthUpdateProfile extends StatefulWidget {
  const ItemDateOfBirthUpdateProfile({
    super.key,
    required this.dateOfBirth,
    required this.onChangeDateOfBirth,
    this.title = '',
  });

  final ValueChanged<DateTime> onChangeDateOfBirth;
  final String title;
  final DateTime dateOfBirth;

  @override
  State<ItemDateOfBirthUpdateProfile> createState() =>
      _ItemDateOfBirthUpdateProfileState();
}

class _ItemDateOfBirthUpdateProfileState
    extends State<ItemDateOfBirthUpdateProfile> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SpacingUnit.x2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                widget.title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colors.text.withValues(alpha: 0.5),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                ' *',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: SpacingUnit.x1_5),
          DatePickerLoop(
            check: false,
            onChange: widget.onChangeDateOfBirth,
            oldDate: widget.dateOfBirth,
          ),
        ],
      ),
    );
  }
}
