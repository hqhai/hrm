import 'dart:convert';
import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/configs/path_config.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/services/attendances.service.dart';
import 'package:common/model/response.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: AttendanceService)
class AttendanceServiceImplement extends BaseService implements AttendanceService {
  late String baseUrl;

  AttendanceServiceImplement() : super() {
    baseUrl = appConfig.baseUserUrl;
  }

  @override
  Future<List<Attendance>> getAttendance(GetAttendanceRequest getAttendanceRequest) async {
    final url = '$baseUrl${PathConfig.getTimeKeepingByEmail}';
    final params = getAttendanceRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    List<Attendance> attendances =
    (data as List<dynamic>).map((e) => Attendance.fromJson(e as Map<String, dynamic>)).toList();
    return attendances;
  }

  @override
  Future<WorkSheet> getWorkSheet({required GetWorkSheetRequest time}) async {
    return const WorkSheet(actualWork: 1,
      holidayWork: 2,
      leaveWork: 3,
      noSalaryWork: 4,
      overTime: 5,
      realWork: 6,
      salaryWork: 7,
      timeEarly: 8,
      timeLate: 9,
      workTime: 10,
    );
  }
}
