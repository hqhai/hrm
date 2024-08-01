import 'package:base_app/domain/entities/work_day/shift.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'shift_state.g.dart';

@CopyWith()
class ShiftState extends Equatable {
  final Shift shift;

  const ShiftState({
    this.shift = const Shift(),
  });

  @override
  List<Object> get props => [shift];
}
