import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'check_in_check_out_gps_state.g.dart';

@CopyWith()
@JsonSerializable()
class CheckInCheckOutGpsState extends Equatable {
  final bool checkTimekeeping;
  final String errorCode;
  final TimekeepingStatus status;

  const CheckInCheckOutGpsState({
    this.status = TimekeepingStatus.init,
    this.checkTimekeeping = false,
    this.errorCode = '',
  });

  @override
  List<Object> get props => [status, checkTimekeeping, errorCode];

  factory CheckInCheckOutGpsState.fromJson(Map<String, dynamic> json) =>
      _$CheckInCheckOutGpsStateFromJson(json);

  Map<String, dynamic> toJson() => _$CheckInCheckOutGpsStateToJson(this);
}
