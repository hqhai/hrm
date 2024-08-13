import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetReasonTypeWidget extends StatefulWidget {
  const BottomSheetReasonTypeWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<EnumReason> onChange;

  @override
  State<BottomSheetReasonTypeWidget> createState() =>
      _BottomSheetReasonTypeWidgetState();
}

class _BottomSheetReasonTypeWidgetState
    extends State<BottomSheetReasonTypeWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x5,
        horizontal: SpacingUnit.x3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderFilter(
              callback: () => close(context),
              title: appLocalizations.reasonType),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: EnumReason.values
                .mapIndexed(
                  (index, element) => GestureDetector(
                    onTap: () => addType(type: element),
                    child: ContainerBorder(
                      backgroundColors: colors.background,
                      borderColors: colors.background,
                      paddingVertical: SpacingUnit.x4,
                      marginTop: SpacingUnit.x4,
                      child: Row(
                        children: [
                          Text(
                            '${index + 1}.    ',
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                          Text(
                            element.configEnumReasonName,
                            style: TextStyle(
                              color: colors.text,
                              fontSize: SpacingUnit.x3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  close(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  addType({required EnumReason type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
