import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/data/models/check_in_setting/create_check_in_setting_request.dart';
import 'package:base_app/domain/repositories/check_in_setting.repository.dart';
import 'package:base_app/domain/services/check_in_setting.service.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckInSettingRepository)
class CheckInSettingRepositoryImpl extends CheckInSettingRepository {
  final CheckInSettingService personnelService;

  CheckInSettingRepositoryImpl() : personnelService = dI<CheckInSettingService>();

  @override
  Future<int> createCheckInSetting({
    String? code,
    required int morningStartTime,
    required int morningEndTime,
    required int afternoonStartTime,
    required int afternoonEndTime,
    required String departmentId,
  }) async {
    int codeStatus = await personnelService.createCheckInSetting(
        createCheckInSettingRequest: CreateCheckInSettingRequest(
          departmentId: departmentId,
      morningStartTime: morningStartTime,
      morningEndTime: morningEndTime,
      afternoonStartTime: afternoonStartTime,
      afternoonEndTime: afternoonEndTime,
    ));
    return codeStatus;
  }
}
