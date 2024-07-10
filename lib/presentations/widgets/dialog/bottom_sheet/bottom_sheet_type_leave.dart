import 'package:base_app/common/enum/work_and_salary_enum.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/domain/entities/leave/filter_leave_history_model.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/custom/app_month_year_picker.dart';
import 'package:base_app/presentations/widgets/custom/container_border.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';
import 'package:widgets/app_button.dart';

class BottomSheetTypeLeaveWidget extends StatefulWidget {
  const BottomSheetTypeLeaveWidget({
    super.key,
    required this.onChange,
    this.filterOld = const FilterLeaveHistoryModel(),
  });

  final FilterLeaveHistoryModel filterOld;
  final ValueChanged<FilterLeaveHistoryModel> onChange;

  @override
  State<BottomSheetTypeLeaveWidget> createState() => _BottomSheetTypeLeaveWidgetState();
}

class _BottomSheetTypeLeaveWidgetState extends State<BottomSheetTypeLeaveWidget> {
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
          MonthYearPicker(
            timeOld: date,
            onChange: (value) => setDate(value),
          ),
          Padding(
            padding: const EdgeInsets.only(top: SpacingUnit.x1, bottom: SpacingUnit.x3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.sourceOfLeave,
                  style: TextStyle(
                      color: colors.text, fontSize: SpacingUnit.x5, fontWeight: FontWeight.w600),
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: SpacingUnit.x4,
                  runSpacing: SpacingUnit.x3,
                  children: TypeLeaveEnum.values
                      .where((e) => e != TypeLeaveEnum.total)
                      .mapIndexed(
                        (index, element) => GestureDetector(
                          onTap: () => setOnChange(
                            type: element,
                          ),
                          child: ContainerBorder(
                            borderColors: element == typeLeave ? colors.success : null,
                            child: Text(
                              element.configTypeLeaveEnum,
                              style: TextStyle(
                                color: element == typeLeave ? colors.success : colors.text,
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
            title: appLocalizations.apply,
            onSubmit: () => onSubmit(),
          )
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
