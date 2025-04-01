import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/title_required.dart';
import 'package:base_app/presentations/widgets/dialog/bottom_sheet/bottom_sheet_explanation_reason.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class ItemCreateTimeKeepingType extends StatefulWidget {
  const ItemCreateTimeKeepingType(
      {super.key, this.onChange, required this.typeDefault});

  final EditTimekeeping typeDefault;
  final ValueChanged<EditTimekeeping>? onChange;

  @override
  State<ItemCreateTimeKeepingType> createState() =>
      _ItemCreateTimeKeepingTypeState();
}

class _ItemCreateTimeKeepingTypeState extends State<ItemCreateTimeKeepingType> {
  EditTimekeeping type = EditTimekeeping.late;

  @override
  void initState() {
    type = widget.typeDefault;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleRequired(title: appLocalizations.caseL, requiredValidate: true),
        GestureDetector(
          onTap: () => _showBottomSheet(context),
          child: ContainerBorder(
            paddingVertical: SpacingUnit.x4,
            borderColors: colors.outline.withValues(alpha: 0.3),
            width: width,
            child: Text(
              type.configEditTimekeepingName,
              style: TextStyle(
                color: colors.text,
                fontSize: SpacingUnit.x4,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: SpacingUnit.x4,
        )
      ],
    );
  }

  _onChangeReasonType(EditTimekeeping value) {
    setState(() {
      type = value;
    });
    widget.onChange?.call(value);
  }

  _showBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return BottomSheetTimeKeepingTypeWidget(
          onChange: (value) => _onChangeReasonType(value),
        );
      },
    );
  }
}
