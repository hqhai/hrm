import 'package:base_app/l10n/app_localizations.dart';
import 'package:base_app/presentations/widgets/activate/create_requisition/overtime/item_create_time_over_time.dart';
import 'package:flutter/material.dart';

class ItemOverTimeWidget extends StatefulWidget {
  const ItemOverTimeWidget({super.key, this.startTime, this.endTime, this.errorTime});

  final String? endTime, startTime, errorTime;


  @override
  State<ItemOverTimeWidget> createState() => _ItemOverTimeWidgetState();
}

class _ItemOverTimeWidgetState extends State<ItemOverTimeWidget> {
  String? endTime, startTime, errorTime;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        ItemCreateTimeOverTime(
          endTimeOld: endTime,
          startTimeOld: startTime,
          error: errorTime,
          dayOrHours: false,
          title: appLocalizations.intervalOnLeave,
          startTime: (value) => setStartTime(value),
          endTime: (value) => setEndTime(value),
          total: (value) => setTotal(value),
        ),
      ],
    );
  }

  setStartTime(String value) {}

  setEndTime(String value) {}

  setTotal(int value) {}
}
