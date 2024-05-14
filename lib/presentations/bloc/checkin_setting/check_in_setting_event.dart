import 'package:equatable/equatable.dart';

class CheckInSettingEvent extends Equatable {
  const CheckInSettingEvent();

  @override
  List<Object?> get props => [];
}

class CreateCheckInSettingEvent extends CheckInSettingEvent {
  final int morningStartTime;
  final int morningEndTime;
  final int afternoonStartTime;
  final int afternoonEndTime;
  final String departmentId;

  const CreateCheckInSettingEvent({
    required this.departmentId,
    required this.morningStartTime,
    required this.morningEndTime,
    required this.afternoonStartTime,
    required this.afternoonEndTime,
  });

  @override
  List<Object?> get props =>
      [departmentId, morningStartTime, morningEndTime, afternoonStartTime, afternoonEndTime];
}
