import 'package:base_app/domain/entities/timekeeping/user_working_history_model.dart';
import 'package:test/test.dart';

UserWorkingHistoryModel userWorkingHistoryModelByDate(List<UserWorkingHistoryModel> list) {
  return list.firstWhere((element) => element.date?.isAtSameMomentAs(DateTime.now()) ?? false);
}

void main() {
  test('test history OT', () {

  });
}
