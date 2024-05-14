abstract class CheckInSettingUseCase {
  Future<int> createCheckInSetting({
    required int morningStartTime,
    required int morningEndTime,
    required int afternoonStartTime,
    required int afternoonEndTime,
    required String departmentId,
  });
}
