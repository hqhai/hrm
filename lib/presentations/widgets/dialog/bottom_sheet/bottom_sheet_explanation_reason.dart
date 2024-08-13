import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/time_keeping_enum.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/common/item_selected.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class BottomSheetTimeKeepingTypeWidget extends StatefulWidget {
  const BottomSheetTimeKeepingTypeWidget({
    super.key,
    required this.onChange,
  });

  final ValueChanged<EditTimekeeping> onChange;

  @override
  State<BottomSheetTimeKeepingTypeWidget> createState() =>
      _BottomSheetTimeKeepingTypeWidgetState();
}

class _BottomSheetTimeKeepingTypeWidgetState
    extends State<BottomSheetTimeKeepingTypeWidget> {
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
          HeaderFilter(
              callback: () => close(context), title: appLocalizations.reason),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: EditTimekeeping.values
                .where((e) => e != EditTimekeeping.editTimekeeping)
                .mapIndexed(
                  (index, element) => GestureDetector(
                      onTap: () => addType(type: element),
                      child: ItemSelected(
                          label: element.configEditTimekeepingName)),
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

  addType({required EditTimekeeping type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
