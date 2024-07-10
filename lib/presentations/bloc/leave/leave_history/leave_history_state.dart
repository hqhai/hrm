import 'package:base_app/domain/entities/leave/user_leave_history.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'leave_history_state.g.dart';

@CopyWith()
class LeaveHistoryState extends Equatable {
  final Map<String, UserLeaveHistory> userLeaveHistory;
  final List<String> listIds;
  final int totalItems;

  const LeaveHistoryState({
    this.userLeaveHistory = const {},
    this.listIds = const [],
    this.totalItems = 0,
  });

  @override
  List<Object?> get props => [
        userLeaveHistory,
        listIds,
        totalItems,
      ];
}
