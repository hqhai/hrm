import 'package:base_app/common/utils/convert.dart';
import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker(
      {super.key, this.check = true, this.restorationId, required this.onChange, this.oldDate});

  final String? restorationId;
  final ValueChanged<DateTime> onChange;
  final DateTime? oldDate;
  final bool check;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> with RestorationMixin {
  //RestorationMixin hỗ trợ khôi phục trạng thái của các widget, giảm bớt mất mát dữ liệu (Thư viện nó bảo thế)
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(BuildContext context, Object? arguments) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        widget.onChange.call(newSelectedDate);
      });
    }
    if (newSelectedDate == null && widget.oldDate != null) {
      _selectedDate.value = widget.oldDate ?? DateTime.now();
      widget.onChange.call(widget.oldDate ?? DateTime.now());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: Container(
          width: SpacingUnit.x40,
          height: SpacingUnit.x12_5,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              SpacingUnit.x2_5,
            ),
            border: Border.all(
              color: const Color(0xff2a6067),
              width: 2,
            ),
          ),
          child: Text(
            getTimeDisplay(),
            style: TextStyle(
                fontSize: widget.check ? SpacingUnit.x5 : SpacingUnit.x4, color: Colors.white),
          )),
    );
  }

  String getTimeDisplay() {
    if (_selectedDate.value.day == DateTime.now().day &&
        _selectedDate.value.month == DateTime.now().month &&
        widget.oldDate != null) {
      return formatYMD(DateFormat('yyyy-MM-dd').format(widget.oldDate ?? DateTime.now()));
    }
    return formatYMD(DateFormat('yyyy-MM-dd').format(_selectedDate.value));
  }
}
