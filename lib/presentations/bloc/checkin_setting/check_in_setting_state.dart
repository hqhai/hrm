import 'package:base_app/common/enum/enum_config.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'check_in_setting_state.g.dart';

@CopyWith()
class CheckInSettingState extends Equatable {
  final CheckInSettingStatus status;

  const CheckInSettingState({this.status = CheckInSettingStatus.init});

  @override
  List<Object> get props => [status];
}
