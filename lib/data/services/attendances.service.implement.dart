import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/common/enum/user_working_history_status.dart';
import 'package:base_app/data/models/request/attendances/get_attendances_request.dart';
import 'package:base_app/data/models/request/attendances/get_work_sheet_request.dart';
import 'package:base_app/domain/entities/attendance.dart';
import 'package:base_app/domain/entities/attendance/work_sheet.dart';
import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:base_app/domain/services/attendances.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: AttendanceService)
class AttendanceServiceImplement extends BaseService implements AttendanceService {
  late String baseUrl;

  AttendanceServiceImplement() : super() {
    baseUrl = appConfig.baseUserUrl;
  }

  @override
  Future<Attendance> getAttendance(GetAttendanceRequest getAttendanceRequest) async {
   /* final url = '$baseUrl${PathConfig.getTimeKeepingByEmail}';
    final params = getAttendanceRequest.toJson();
    final response = await client.get(url, params: params);
    final responseBase = ResponseBase.fromJson(json.decode(response.body));
    final data = responseBase.result;
    final Attendance attendances = Attendance.fromJson(data);*/
    final Attendance attendanceLocal = Attendance(
      timeLate: 1,
      timeEarly: 2,
      salaryWork: 3,
      overTime: 4,
      name: "Trẻ con sa mạc truyền tai nhau rằng",
      actualRate: 5,
      code: 'Xương rồng đơm lá đơm hoa',
      countEarly: 6,
      countLate: 7,
      holidayRate: 8,
      leaveRate: 9,
      noSalaryRate: 10,
      overTimeRate: 11,
      realRate: 12,
      userId: "Dòng nước đong đầy trên cao nguyên đá",
      overTimeDay: EnumOvertimeDay.noShiftsWork,
      workTimeActual: 13,
      workTimeReal: 15,
      userWorkingHistories: [
        UserWorkingHistoryModel(
          workTimeReal: 1,
          workTimeActual: 2,
          userId: "Dòng nước đong đầy trên cao nguyên đá",
          overTimeDay: EnumOvertimeDay.noShiftsWork,
          realRate: 3,
          overTimeRate: 4,
          noSalaryRate: 5,
          leaveRate: 6,
          holidayRate: 7,
          actualRate: 8,
          overTime: 9,
          timeEarly: 10,
          timeLate: 11,
          date: DateTime(2024, 7, 16, 0, 0, 0),
          status: [
            UserWorkingHistoryStatus.holiday,
            UserWorkingHistoryStatus.onTime,
            UserWorkingHistoryStatus.noAttendance
          ],
          checkIn: 30600,
          checkOut: 59400,
          requestIds: ['2fa1ab1a-11a1-4b0d-b9c0-b702ff01fddd'],
          salaryRate: 12,
          workShiftDetailId: 'Là Ngày hoàng đế trở về nhà',
          workShiftId: ':)))))',
        ),
      ],
    );
    return attendanceLocal;
  }

  @override
  Future<WorkSheet> getWorkSheet({required GetWorkSheetRequest time}) async {
    return const WorkSheet(
      actualWork: 1,
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
