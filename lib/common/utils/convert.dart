import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/common/enum/value_string.dart';
import 'package:base_app/presentations/bloc/language/language_cubit.dart';
import 'package:intl/intl.dart';

String strSeconds(int time) {
  final Duration duration = Duration(seconds: time);
  final DateTime now = DateTime.now();
  final DateTime startOfDay = DateTime(now.year, now.month, now.day, 0, 0, 0);
  final DateTime result = startOfDay.add(duration);
  return time != 0 ? formatHM(result.toString()) : '';
}

String formatIso8601(String? time) {
  DateTime dateTime1 = DateTime.parse(time ?? DateTime.now().toString());
  String time1 = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime1);
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

String formatYMD(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
  return '';
}

String formatWeekDay(int weekDayIndex) {
  bool checkLanguage = dI<LanguageCubit>().state.languageCode == LanguageEnum.en;
  List weekDayToString =
      WeekDayEnum.values.map((e) => setElementWeekDay(e, checkLanguage)).toList();
  return weekDayToString[weekDayIndex - 1];
}

setElementWeekDay(WeekDayEnum e, bool checkLanguage) {
  if (checkLanguage) {
    return e.nameEn;
  } else {
    return e.nameVi;
  }
}

String formatDMY(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd-MM-yyyy').format(dateTime);
  }
  return '';
}

String formatHMS(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm:ss').format(dateTime);
  }
  return '';
}

String formatHMByH(String time) {
  if (time != '') {
    String dateTimeString = '2000-01-18 $time:00';
    DateTime dateTime = DateTime.parse(dateTimeString);
    String a = DateFormat('HH:mm').format(dateTime);
    return a;
  }
  return '';
}

String formatHM(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm').format(dateTime);
  }
  return '';
}

String formatDHM(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('dd HH:mm').format(dateTime);
  }
  return '';
}

DateTime formatDateHM(String time) {
  return DateFormat('HH:mm').parse(time);
}

String formatYM(int year, int month) {
  DateTime dateTime = DateTime(year, month);
  return DateFormat('yyyy-MM').format(dateTime);
}

DateTime? dateTimeLocal(DateTime? time) {
  if (time != null) {
    return time.add(const Duration(hours: 7));
  }
  return null;
}

String formatYMDHMS(String time) {
  if (time == '') {
    return '';
  } else {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
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
