import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/gender_bottom_sheet.dart';
import 'package:flutter/material.dart';
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
  GenderEnum gender = GenderEnum.other;

  @override
  void initState() {
    gender = widget.gender;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ItemGenderUpdateProfile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.gender != oldWidget.gender && widget.gender != gender) {
      setState(() => gender = widget.gender);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
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
                l10n.gender,
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
          GestureDetector(
            onTap: () => _showBottomSheet(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: SpacingUnit.x3,
                vertical: SpacingUnit.x3,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(SpacingUnit.x2_5),
                border: Border.all(
                  color: colors.text.withValues(alpha: 0.12),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    gender.configGenderName,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.text,
                      fontSize: 14,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: colors.text.withValues(alpha: 0.4),
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return GenderBottomSheetWidget(
          gender: gender,
          onChange: (value) => _setGender(value),
        );
      },
    );
  }

  void _setGender(GenderEnum value) {
    setState(() {
      gender = value;
      widget.onChangeGender.call(value);
    });
  }
}
