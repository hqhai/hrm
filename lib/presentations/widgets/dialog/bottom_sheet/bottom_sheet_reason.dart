import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/requisition_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/common/item_selected.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BottomSheetReasonTypeWidget extends StatefulWidget {
  const BottomSheetReasonTypeWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<EnumReason> onChange;

  @override
  State<BottomSheetReasonTypeWidget> createState() => _BottomSheetReasonTypeWidgetState();
}

class _BottomSheetReasonTypeWidgetState extends State<BottomSheetReasonTypeWidget> {
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: SpacingUnit.x5,
        horizontal: SpacingUnit.x3,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderFilter(callback: () => close(context), title: appLocalizations.reasonType),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: EnumReason.values.where((e) => e != EnumReason.unknown)
                .mapIndexed(
                  (index, element) => GestureDetector(
                      onTap: () => addType(type: element),
                      child: ItemSelected(label: element.configEnumReasonName)),
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
