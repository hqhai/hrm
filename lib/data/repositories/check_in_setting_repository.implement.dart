import 'package:base_app/data/models/check_in_setting/create_check_in_setting_request.dart';
import 'package:base_app/domain/repositories/check_in_setting.repository.dart';
import 'package:injectable/injectable.dart';

import '../source/api/services/check_in_setting_service.dart';

@LazySingleton(as: CheckInSettingRepository)
class CheckInSettingRepositoryImpl extends CheckInSettingRepository {
  final CheckInSettingService _personnelService;

  CheckInSettingRepositoryImpl(this._personnelService);

  @override
  Future<int?> createCheckInSetting({
    String? code,
    required int morningStartTime,
    required int morningEndTime,
    required int afternoonStartTime,
    required int afternoonEndTime,
    required String departmentId,
  }) async {
    final data = await _personnelService.createCheckInSetting(
        createCheckInSettingRequest: CreateCheckInSettingRequest(
      departmentId: departmentId,
      morningStartTime: morningStartTime,
      morningEndTime: morningEndTime,
      afternoonStartTime: afternoonStartTime,
      afternoonEndTime: afternoonEndTime,
    ));
    return data?.statusCode;
  }
}
