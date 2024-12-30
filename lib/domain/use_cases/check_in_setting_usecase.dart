import 'package:base_app/domain/repositories/check_in_setting.repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class CheckInSettingUseCase {
  CheckInSettingUseCase(this._personnelRepository);

  final CheckInSettingRepository _personnelRepository;

  Future<int> createCheckInSetting({
    required int morningStartTime,
    required int morningEndTime,
    required int afternoonStartTime,
    required int afternoonEndTime,
    required String departmentId,
  }) async {
    final response = await _personnelRepository.createCheckInSetting(
      morningStartTime: morningStartTime,
      morningEndTime: morningEndTime,
      afternoonStartTime: afternoonStartTime,
      afternoonEndTime: afternoonEndTime,
      departmentId: departmentId,
    );
    return response ?? 0;
  }
}
