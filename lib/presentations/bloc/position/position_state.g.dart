// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$PositionStateCWProxy {
  PositionState position(Position position);

  PositionState positions(List<Position> positions);

  PositionState status(PositionStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PositionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PositionState(...).copyWith(id: 12, name: "My name")
  /// ````
  PositionState call({
    Position? position,
    List<Position>? positions,
    PositionStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfPositionState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfPositionState.copyWith.fieldName(...)`
class _$PositionStateCWProxyImpl implements _$PositionStateCWProxy {
  final PositionState _value;

  const _$PositionStateCWProxyImpl(this._value);

  @override
  PositionState position(Position position) => this(position: position);

  @override
  PositionState positions(List<Position> positions) =>
      this(positions: positions);

  @override
  PositionState status(PositionStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `PositionState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// PositionState(...).copyWith(id: 12, name: "My name")
  /// ````
  PositionState call({
    Object? position = const $CopyWithPlaceholder(),
    Object? positions = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return PositionState(
      position: position == const $CopyWithPlaceholder() || position == null
          ? _value.position
          // ignore: cast_nullable_to_non_nullable
          : position as Position,
      positions: positions == const $CopyWithPlaceholder() || positions == null
          ? _value.positions
          // ignore: cast_nullable_to_non_nullable
          : positions as List<Position>,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as PositionStatus,
    );
  }
}

extension $PositionStateCopyWith on PositionState {
  /// Returns a callable class that can be used as follows: `instanceOfPositionState.copyWith(...)` or like so:`instanceOfPositionState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$PositionStateCWProxy get copyWith => _$PositionStateCWProxyImpl(this);
}
