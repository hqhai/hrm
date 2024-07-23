import 'package:base_app/common/utils/color_utils.dart';
import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_bloc.dart';
import 'package:base_app/presentations/bloc/work_day/work_day_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themes/themes.dart';

class ItemDayOfList extends StatefulWidget {
  const ItemDayOfList({super.key, required this.dateTime, this.workDayId, required this.type});

  final DateTime dateTime;
  final String? workDayId;
  final ValueChanged<double> type;

  @override
  State<ItemDayOfList> createState() => _ItemDayOfListState();
}

class _ItemDayOfListState extends State<ItemDayOfList> {
  late GlobalKey _key;

  double heightWidget = 0;

  @override
  void initState() {
    _key = GlobalKey(debugLabel: widget.dateTime.toString());
    super.initState();
  }

  DateTime date(WorkDayState state) {
    final dateType = DateTime(widget.dateTime.year, widget.dateTime.month, widget.dateTime.day);
    return dateType;
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;
      setState(() {
        heightWidget = renderBox.size.height;
        widget.type.call(heightWidget);
      });
    });
    final colors = AppTheme.getColors(context);
    final width = MediaQuery.sizeOf(context).width;
    return BlocBuilder<WorkDayBloc, WorkDayState>(
      builder: (context, state) {
        final workDay = state.workDays[date(state)];
        return Container(
          key: _key,
          child: Column(
            children: [
              Container(
                width: width,
                color: colors.surfaceVariantLow,
                child: Padding(
                  padding: const EdgeInsets.all(SpacingUnit.x3),
                  child: Text(
                    '${nameWeekDay(widget.dateTime)}, ${dayMonthYear(
                      time: widget.dateTime,
                      context: context,
                    )}',
                    style: TextStyle(
                        color: colors.text,
                        fontSize: SpacingUnit.x3_5,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              workDay != null
                  ? Column(
                      children: workDay.items
                          .map(
                            (e) => Container(
                              margin: const EdgeInsets.all(SpacingUnit.x2),
                              padding: const EdgeInsets.all(SpacingUnit.x2),
                              width: width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(SpacingUnit.x2),
                                color: CustomsColor.colorBackground,
                                border: Border.all(
                                  color: colors.text,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${formatYMD(e.startTime.toString())} - ${formatYMD(e.endTime.toString())}',
                                    style: TextStyle(
                                      color: colors.text,
                                      fontSize: SpacingUnit.x3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(SpacingUnit.x7),
                      child: Text(
                        'Không có ca làm việc',
                        style: TextStyle(
                          color: colors.text,
                          fontSize: SpacingUnit.x3_5,
                        ),
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
