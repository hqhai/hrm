import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/dialog/filter_request/item/header_filter.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetOverTimeDayWidget extends StatefulWidget {
  const BottomSheetOverTimeDayWidget({
    super.key,
    required this.onChange,
    this.overtimeDay = EnumOvertimeDay.holiday,
  });

  final ValueChanged<EnumOvertimeDay> onChange;
  final EnumOvertimeDay overtimeDay;

  @override
  State<BottomSheetOverTimeDayWidget> createState() => _BottomSheetOverTimeDayWidgetState();
}

class _BottomSheetOverTimeDayWidgetState extends State<BottomSheetOverTimeDayWidget> {
  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          HeaderFilter(callback: () => close(context), title: appLocalizations.dateType),
          Column(
              mainAxisSize: MainAxisSize.min,
              children: EnumOvertimeDay.values
                  .where((element) => element != EnumOvertimeDay.unknown)
                  .mapIndexed((index, element) => GestureDetector(
                        onTap: () => setOnChange(type: element),
                        child: Container(
                          padding: const EdgeInsets.all(SpacingUnit.x2_5),
                          margin: const EdgeInsets.only(bottom: SpacingUnit.x3),
                          decoration: BoxDecoration(
                              // borderRadius: BorderRadius.circular(SpacingUnit.x2),
                              border:
                                  Border(bottom: BorderSide(width: 0.1, color: colors.textLight))),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  element.configEnumOvertimeDayName,
                                  style: TextStyle(
                                    color: colors.text,
                                    fontSize: SpacingUnit.x3,
                                  ),
                                ),
                              ),
                              if (widget.overtimeDay == element)
                                Icon(
                                  Icons.check,
                                  color: colors.primary,
                                )
                            ],
                          ),
                        ),
                      ))
                  .toList()),
        ],
      ),
    );
  }

  close(BuildContext context) {
    dI<AppNavigation>().pop(context);
  }

  setOnChange({required EnumOvertimeDay type}) {
    widget.onChange.call(type);
    Navigator.of(context).pop();
  }
}
