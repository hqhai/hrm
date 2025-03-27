import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/leave/filter_leave_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:base_app/presentations/widgets/custom/month_picker.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class BottomSheetTypeLeaveWidget extends StatefulWidget {
  const BottomSheetTypeLeaveWidget({
    super.key,
    required this.onChange,
    this.filterOld = const FilterLeaveHistoryModel(),
  });

  final FilterLeaveHistoryModel filterOld;
  final ValueChanged<FilterLeaveHistoryModel> onChange;

  @override
  State<BottomSheetTypeLeaveWidget> createState() =>
      _BottomSheetTypeLeaveWidgetState();
}

class _BottomSheetTypeLeaveWidgetState
    extends State<BottomSheetTypeLeaveWidget> {
  TypeLeaveEnum? typeLeave;
  DateTime? date = DateTime.now();

  @override
  void initState() {
    typeLeave = widget.filterOld.type;
    date = widget.filterOld.date;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(SpacingUnit.x3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          MonthPickerLoop(
            requiredValidate: false,
            title: appLocalizations.time,
            oldDate: date,
            onChange: (value) => setDate(value),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: SpacingUnit.x7_5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.sourceOfLeave,
                  style: TextStyle(
                      color: colors.text,
                      fontSize: SpacingUnit.x5,
                      fontWeight: FontWeight.w600),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: SpacingUnit.x4,
                  runSpacing: SpacingUnit.x3,
                  children: TypeLeaveEnum.values
                      .where((e) =>
                          e != TypeLeaveEnum.total &&
                          e != TypeLeaveEnum.unknown)
                      .mapIndexed(
                        (index, element) => GestureDetector(
                          onTap: () => setOnChange(
                            type: element,
                          ),
                          child: ContainerBorder(
                            paddingVertical: 8,
                            marginTop: 8,
                            backgroundColors: element == typeLeave
                                ? colors.blue
                                : colors.background,
                            borderColors: element == typeLeave
                                ? colors.blue
                                : colors.text.withValues(alpha: 0.3),
                            child: Text(
                              element.configTypeLeaveEnum,
                              style: TextStyle(
                                color: element == typeLeave
                                    ? colors.background
                                    : colors.text,
                                fontSize: SpacingUnit.x3,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          AppButton(
            color: colors.blue,
            colorText: colors.background,
            title: appLocalizations.apply,
            onSubmit: () => onSubmit(),
          ),
          const SizedBox(height: SpacingUnit.x8)
        ],
      ),
    );
  }

  setDate(DateTime value) {
    setState(() {
      date = value;
    });
  }

  setOnChange({required TypeLeaveEnum type}) {
    setState(() {
      typeLeave = type;
    });
  }

  onSubmit() {
    widget.onChange.call(FilterLeaveHistoryModel(type: typeLeave, date: date));
    Navigator.of(context).pop();
  }
}
