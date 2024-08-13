import 'package:base_app/common/enum/user_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
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
  State<ItemGenderUpdateProfile> createState() => _ItemGenderUpdateProfileState();
}

class _ItemGenderUpdateProfileState extends State<ItemGenderUpdateProfile> {
  GenderEnum gender = GenderEnum.other;

  @override
  void initState() {
    gender = widget.gender;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          appLocalizations.gender,
          style: TextStyle(
            color: colors.text,
            fontSize: SpacingUnit.x4,
            fontWeight: FontWeight.w600,
          ),
        ),
        ContainerBorder(
          borderColors: colors.surfaceBright.withOpacity(0.6),
          padding: SpacingUnit.x4,
          width: width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gender.configGenderName,
                style: TextStyle(
                  color: colors.text,
                  fontSize: SpacingUnit.x4,
                ),
              ),
              InkWell(
                onTap: () => _showBottomSheet(
                  context,
                ),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: colors.text,
                  size: SpacingUnit.x6,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return GenderBottomSheetWidget(
          gender: gender,
          onChange: (value) => setGender(value),
        );
      },
    );
  }

  setGender(GenderEnum value) {
    setState(() {
      gender = value;
      widget.onChangeGender.call(value);
    });
  }
}
