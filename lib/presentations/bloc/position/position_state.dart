import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/position.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
part 'position_state.g.dart';

@CopyWith()
class PositionState extends Equatable {
  final Position position;
  final List<Position> positions;
  final PositionStatus status;

  const PositionState(
      {this.position = const Position(
          name: '',
          description: '',
          id: '',
          createdUserId: '',
          createdFullName: '',
          createdDate: ''),
      this.positions = const [],
      this.status = PositionStatus.init});

  @override
  List<Object> get props => [position, positions, status];
}
