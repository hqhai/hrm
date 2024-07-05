import 'package:base_app/common/enum/timekeeping_status.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'check_in_check_out_gps_state.g.dart';

@CopyWith()
class CheckInCheckOutGpsState extends Equatable {
  final bool checkTimekeeping;
  final TimekeepingStatus status;

  const CheckInCheckOutGpsState({
    this.status = TimekeepingStatus.init,
    this.checkTimekeeping = false
  });

  @override
  List<Object> get props => [status, checkTimekeeping];
}
