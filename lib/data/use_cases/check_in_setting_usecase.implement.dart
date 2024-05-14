import 'package:base_app/common/configs/locators.dart';
import 'package:base_app/domain/repositories/check_in_setting.repository.dart';
import 'package:base_app/domain/use_cases/check_in_setting_usecase.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CheckInSettingUseCase)
class CheckInSettingUseCaseImpl extends CheckInSettingUseCase {
  final CheckInSettingRepository _personnelRepository;

  CheckInSettingUseCaseImpl() : _personnelRepository = dI<CheckInSettingRepository>();

  @override
  Future<int> createCheckInSetting({
    required int morningStartTime,
    required int morningEndTime,
    required int afternoonStartTime,
    required int afternoonEndTime,
    required String departmentId,
  }) async {
    return await _personnelRepository.createCheckInSetting(
      morningStartTime: morningStartTime,
      morningEndTime: morningEndTime,
      afternoonStartTime: afternoonStartTime,
      afternoonEndTime: afternoonEndTime,
        departmentId: departmentId
    );
  }
}
