import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:intl/intl.dart';

String formatIso8601(String time) {
  DateTime dateTime1 = DateTime.parse(time);
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

String formatHMS(String time) {
  if (time != '') {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('HH:mm:ss').format(dateTime);
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

String formatYM(int year, int month) {
  DateTime dateTime = DateTime(year, month);
  return DateFormat('yyyy-MM').format(dateTime);
}

String formatYMDHMS(String time) {
  if (time == '') {
    return '';
  } else {
    DateTime dateTime = DateTime.parse(time);
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }
}

Future<String> convertToBase64(File imageFile) async {
  Uint8List imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Url.encode(imageBytes);
  return base64Image;
}
