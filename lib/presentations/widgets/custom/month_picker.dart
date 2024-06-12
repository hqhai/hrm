import 'package:base_app/common/utils/spacing_unit.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({super.key, this.check = true, this.restorationId, required this.onChange, this.oldDate = ''});

  final String? restorationId;
  final ValueChanged<String> onChange;
  final String oldDate;
  final bool check;

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> with RestorationMixin {
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
        getTime = DateFormat('yyyy-MM').format(_selectedDate.value);
        widget.onChange.call(getTime);
      });
    }
  }

  String getTime = '';

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
            borderRadius: BorderRadius.circular(SpacingUnit.x2_5,),
            border: Border.all(
              color: const Color(0xff2a6067),
              width: 2,
            ),
          ),
          child: Text(
            getTimeDisplay(),
            style: TextStyle(fontSize: widget.check ? SpacingUnit.x5 : SpacingUnit.x4, color: Colors.white),
          )),
    );
  }

  String getTimeDisplay(){
    return getTime == ''
        ? widget.oldDate != ''
        ? widget.oldDate
        : DateFormat('yyyy-MM').format(DateTime.now())
        : getTime;
  }
}
