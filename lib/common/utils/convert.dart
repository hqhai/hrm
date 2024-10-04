import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/common/utils/menu_values.dart';
import 'package:base_app/l10n/app_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/// Từ int sang khoảng thời gian
String strTimeFromInt(int time) {
  int hours = time~/3600;
  int second = time%3600;
  int minute = second~/60;
  if(second == 0){
    return '${hours}h';
  }
  return '${hours}h${minute}m';
}

///String sang int
int timeToSeconds(String time) {
  final DateFormat format = DateFormat('HH:mm:ss');
  final DateTime t1 = format.parse(time);
  final DateTime t2 = format.parse("00:00:00");
  return t1.difference(t2).inSeconds;
}

///Từ int sang String
String? strSeconds(int? time) {
  if (time != null) {
    final Duration duration = Duration(seconds: time);
    final DateTime now = DateTime.now();
    final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final DateTime result = startOfDay.add(duration);
    return formatHM(result.toString());
  }
  return null;
}

///Từ int sang DateTime
DateTime secondToDateTime({int time = 0}) {
  final Duration duration = Duration(seconds: time);
  final DateTime now = DateTime.now();
  final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
  final DateTime result = startOfDay.add(duration);
  return result;
}

///DateTime sang int
int dateTimeToSeconds({required DateTime time}) {
  final timeZero = DateTime(time.year, time.month, time.day, 0, 0, 0);
  return time.difference(timeZero).inSeconds;
}

///SO sánh có cùng ngày không
bool isAtSameMomentAsDay({
  DateTime? start,
  DateTime? end,
}) {
  if (start != null && end != null) {
    return start.year == end.year && start.month == end.month && start.day == end.day;
  }
  return false;
}

///Ngày đầu của tháng
DateTime getFirstDayOfMonth(DateTime time) {
  final int year = time.year;
  final int month = time.month;
  return DateTime(year, month, 1);
}

///Ngày cuối của tháng
DateTime getLastDayOfMonth(DateTime time) {
  final int year = time.year;
  final int month = time.month;
  var firstDayNextMonth = (month < 12) ? DateTime(year, month + 1, 1) : DateTime(year + 1, 1, 1);
  return firstDayNextMonth.subtract(const Duration(days: 1));
}

///Chuyển dạng Iso8601
String formatIso8601(String? time) {
  DateTime dateTime1 = DateTime.parse(time ?? DateTime.now().toString());
  String time1 = DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime1);
  List<String> inputDateParts = time1.split(' ');
  List<String> dateParts = inputDateParts[0].split('-');
  List<String> timeParts = inputDateParts[1].split(':');

  DateTime dateTime = DateTime(
    int.parse(dateParts[0]),
    int.parse(dateParts[1]),
    int.parse(dateParts[2]),
    int.parse(timeParts[0]),
    int.parse(timeParts[1]),
    int.parse(timeParts[2]),
  );
  return dateTime.toIso8601String();
}

///Định dạng Năm Tháng Ngày
String formatYMD(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  return '';
}

///Định dạng Năm Tháng
String formatMY(DateTime? time) {
  if (time != null) {
    return DateFormat('MM-yyyy').format(time);
  }
  return '';
}

String formatYYMMDD(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  return '';
}

///Từ số sang thứ trong tuần
String formatWeekDay(int weekDayIndex) {
  List weekDayToString = WeekDayEnum.values.map((e) => e.configWeekDayEnumName).toList();
  return weekDayToString[weekDayIndex - 1];
}

///Từ date sang thứ trong tuần

String nameWeekDay(DateTime? time) {
  if (time != null) {
    final int nowOfWeek = mapNumberDayInWeek[DateFormat('EEE').format(time)] ?? 0;
    final List<String> weekDayToString =
        WeekDayEnum.values.map((e) => e.configWeekDayEnumName).toList();
    return weekDayToString[nowOfWeek - 1];
  }
  return '';
}

///Ngày, tháng, năm
String dayMonthYear({DateTime? time, required BuildContext context}) {
  final appLocalizations = AppLocalizations.of(context)!;
  if (time != null) {
    return ' ${appLocalizations.day} ${time.day} ${appLocalizations.month} ${time.month} ${appLocalizations.year} ${time.year}';
  }
  return '';
}

///Định dạng Ngyaf Tháng Năm
String formatDMY(String time) {
  if (time != '' && time != 'null') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }
  return '';
}

///Định dạng Giờ Phút Giây
String formatHMS(String? time) {
  if (time != '' && time != null) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm:ss').format(dateTime);
  }
  return '';
}

///Định dạng Giờ
String formatHMByH(String time) {
  if (time != '') {
    String dateTimeString = '2000-01-18 $time:00';
    DateTime dateTime = DateTime.parse(dateTimeString);
    String a = DateFormat('HH:mm').format(dateTime);
    return a;
  }
  return '';
}

///Định dạng Giờ Phút
String formatHM(String? time) {
  if (time != '' && time != null) {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm').format(dateTime);
  }
  return '';
}

///Định dạng Ngày Giờ Phút
String formatDHM(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd HH:mm').format(dateTime);
  }
  return '';
}

///Định dạng Giờ Phút
DateTime formatDateHM(String time) {
  return DateFormat('HH:mm').parse(time);
}

///Định dạng Năm Tháng
String formatYM(int year, int month) {
  DateTime dateTime = DateTime(year, month);
  return DateFormat('MM/yyyy').format(dateTime);
}

///Gừi local
DateTime? dateTimeLocal(DateTime? time) {
  if (time != null) {
    return time.add(const Duration(hours: 7));
  }
  return null;
}

String formatYMDHMS(String? time) {
  if (time == '' && time != null) {
    return '';
  } else {
    DateTime dateTime = DateTime.parse(time!);
    return DateFormat('dd/MM/yyyy HH:mm:ss').format(dateTime);
  }
}

String formatMSDMY(String? time) {
  if (time == '' && time != null) {
    return '';
  } else {
    DateTime dateTime = DateTime.parse(time!);
    return DateFormat('HH:mm dd-MM-yyyy').format(dateTime);
  }
}

String formatM(String time) {
  if (time == '') {
    return '';
  } else {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM').format(dateTime);
  }
}

Future<String> convertToBase64(File imageFile) async {
  Uint8List imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Url.encode(imageBytes);
  return base64Image;
}

bool listStatusRequestEquals<StatusRequestEnum>(
    List<StatusRequestEnum>? list1, List<StatusRequestEnum>? list2) {
  if (list1 == null) {
    return list2 == null;
  }
  if (list2 == null || list1.length != list2.length) {
    return false;
  }
  if (identical(list1, list2)) {
    return true;
  }
  for (int index = 0; index < list1.length; index += 1) {
    if (list1[index] != list2[index]) {
      return false;
    }
  }
  return true;
}

String countStatus(int count){
  if(count > 99) {
    return '99+';
  }
  if(count <= 99 && count >= 10){
    return '$count';
  }
  return ' $count ';
}
