import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/type_filter_work_shift.dart';
import 'package:base_app/common/routers/navigation.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/common/utils/time_utils.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/item_activate.dart';
import 'package:base_app/presentations/widgets/custom/app_button.dart';
import 'package:base_app/presentations/widgets/dialog/calendar_list_day/layout_calendar_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:themes/themes.dart';

class FilterDateTimeWork extends StatefulWidget {
  final ValueChanged<DateTime> changeStartTime;
  final ValueChanged<DateTime> changeEndTime;
  final DateTime startTime;
  final DateTime endTime;
  final VoidCallback callBack;
  final ValueChanged<FilterType> onChangeFilterType;

  const FilterDateTimeWork({
    super.key,
    required this.changeStartTime,
    required this.changeEndTime,
    required this.startTime,
    required this.endTime,
    required this.callBack,
    required this.onChangeFilterType,
  });

  @override
  State<FilterDateTimeWork> createState() => _FilterDateTimeWorkState();
}

class _FilterDateTimeWorkState extends State<FilterDateTimeWork> {
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  int checkFilter = 1;

  @override
  void initState() {
    startTime = widget.startTime;
    endTime = widget.endTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return SizedBox(
      height: height * 0.95,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (checkFilter == 1)
            Expanded(
              child: _selectFilterWidget(context),
            ),
          if (checkFilter == 2)
            Expanded(
              child: _selectFilterMonthWidget(context),
            ),
          if (checkFilter == 3)
            Expanded(
              child: _selectFilterDayToDayWidget(context),
            ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButton(
                    color: colors.blue.withOpacity(0.2),
                    colorBorder: colors.blue.withOpacity(0.2),
                    colorText: colors.primary,
                    title: appLocalizations.cancel,
                    onSubmit: () => dI<AppNavigation>().pop(context),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x4),
                  child: AppButton(
                    color: colors.primary,
                    colorBorder: colors.primary,
                    colorText: colors.background,
                    title: appLocalizations.confirm,
                    onSubmit: () => _setTime(context),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _filterMonth() {
    setState(() {
      checkFilter = 2;
    });
  }

  _filterDayToDay() {
    setState(() {
      checkFilter = 3;
    });
  }

  _filterAll() {
    setState(() {
      checkFilter = 1;
    });
  }

  Widget _selectFilterWidget(BuildContext context) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingUnit.x4,
            top: SpacingUnit.x4,
          ),
          child: Text(
            appLocalizations.selectFilter,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        ItemActivateWidget(
          padding: 0,
          paddingVertical: SpacingUnit.x2,
          color: Colors.transparent,
          title: appLocalizations.filterByMonth,
          callback: () => _filterMonth(),
        ),
        ItemActivateWidget(
          padding: 0,
          paddingVertical: SpacingUnit.x2,
          color: Colors.transparent,
          title: appLocalizations.filterByDay,
          callback: () => _filterDayToDay(),
        ),
      ],
    );
  }

  Widget _selectFilterMonthWidget(
    BuildContext context,
  ) {
    final colors = AppTheme.getColors(context);
    final appLocalizations = AppLocalizations.of(context)!;
    final now = DateTime.now();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingUnit.x4,
            top: SpacingUnit.x4,
          ),
          child: InkWell(
            onTap: () => _filterAll(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.left_chevron,
                  color: colors.orange,
                  size: SpacingUnit.x4,
                ),
                Text(
                  appLocalizations.selectFilter,
                  style: TextStyle(
                    color: colors.orange,
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingUnit.x4,
            top: SpacingUnit.x4,
          ),
          child: Text(
            appLocalizations.filterByMonth,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(SpacingUnit.x4),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: SpacingUnit.x3,
                  crossAxisSpacing: SpacingUnit.x3,
                  childAspectRatio: 3),
              itemCount: GetMonth.mapMonthName.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () => _setMonth(DateTime(
                  now.year,
                  index + 1,
                )),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SpacingUnit.x2),
                    color: startTime.month == index + 1
                        ? colors.blue.withOpacity(0.1)
                        : Colors.transparent,
                  ),
                  child: Center(
                    child: Text(
                      GetMonth.mapMonthName[index + 1] ?? '',
                      style: TextStyle(
                        color: startTime.month == index + 1 ? colors.primary : colors.text,
                        fontSize: SpacingUnit.x4,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _selectFilterDayToDayWidget(
    BuildContext context,
  ) {
    final appLocalizations = AppLocalizations.of(context)!;
    final colors = AppTheme.getColors(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingUnit.x4,
            top: SpacingUnit.x4,
          ),
          child: InkWell(
            onTap: () => _filterAll(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.left_chevron,
                  color: colors.orange,
                  size: SpacingUnit.x4,
                ),
                Text(
                  appLocalizations.selectFilter,
                  style: TextStyle(
                    color: colors.orange,
                    fontSize: SpacingUnit.x3_5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: SpacingUnit.x4,
            top: SpacingUnit.x4,
          ),
          child: Text(
            appLocalizations.filterByMonth,
            style: TextStyle(
              color: colors.text,
              fontSize: SpacingUnit.x6,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        LayoutCalendarDialog(
          startTimeOld: startTime,
          endTimeOld: endTime,
          bottomButton: false,
          callBackEndTime: (value) => setState(() {
            endTime = value ?? DateTime.now();
          }),
          callBackStartTime: (value) => setState(() {
            startTime = value ?? DateTime.now();
          }),
        )
      ],
    );
  }

  _setMonth(DateTime dateTime) {
    setState(() {
      startTime = getFirstDayOfMonth(dateTime);
      endTime = getLastDayOfMonth(dateTime);
    });
  }

  setCall() {
    widget.changeEndTime.call(endTime);
    widget.changeStartTime.call(startTime);
    widget.callBack.call();
  }

  _setTime(BuildContext context) {
    if (checkFilter == 2) {
      widget.onChangeFilterType.call(FilterType.month);
      setCall();
    }
    if (checkFilter == 3) {
      widget.onChangeFilterType.call(FilterType.day);
      setCall();
    }
    dI<AppNavigation>().pop(context);
  }
}

//mapMonthName
