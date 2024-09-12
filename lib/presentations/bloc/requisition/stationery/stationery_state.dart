import 'package:base_app/common/enum/stationery_enum.dart';
import 'package:base_app/domain/entities/requisition/stationery/stationery.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'stationery_state.g.dart';

@CopyWith()
@JsonSerializable()
class StationeryState extends Equatable {
  final List<Stationery> stationeries;
  final StationeryStatus status;
  final int countItem;
  final String name;

  const StationeryState(
      {this.name = '',
      this.countItem = 0,
      this.stationeries = const [],
      this.status = StationeryStatus.init});

  @override
  List<Object> get props => [stationeries, status];

  factory StationeryState.fromJson(Map<String, dynamic> json) => _$StationeryStateFromJson(json);

  Map<String, dynamic> toJson() => _$StationeryStateToJson(this);
}
