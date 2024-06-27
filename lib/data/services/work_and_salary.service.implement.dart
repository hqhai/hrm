import 'package:base_app/common/configs/app_configs.dart';
import 'package:base_app/data/models/work_and_salary/leave_day.dart';
import 'package:base_app/data/models/work_and_salary/start_end.dart';
import 'package:base_app/domain/services/work_and_salary.service.dart';
import 'package:injectable/injectable.dart';

import 'base.service.dart';

@LazySingleton(as: WorkAndSalaryService)
class WorkAndSalaryServiceImpl extends BaseService implements WorkAndSalaryService {
  late String baseUrl;
  late String baseURLFile;
  late String baseUrlUser;

  WorkAndSalaryServiceImpl() : super() {
    baseUrl = appConfig.baseRequestUrl;
    baseURLFile = appConfig.baseURLFile;
    baseUrlUser = appConfig.baseUserUrl;
  }

  @override
  Future<LeaveDayResponse> totalLeaveDay() async {
    return const LeaveDayResponse(permission: 66, used: 77, remaining: 1508);
  }

  @override
  Future<double> totalWorkday({required StartEndResponse startEndResponse}) async {
    return 1801;
  }
}
