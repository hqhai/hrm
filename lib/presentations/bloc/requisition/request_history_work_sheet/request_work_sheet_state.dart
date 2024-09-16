import 'package:base_app/domain/entities/requisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'request_work_sheet_state.g.dart';

@CopyWith()
@JsonSerializable()
class RequestWorkSheetState extends Equatable {
  final Map<String, Request> mapRequests;
  final List<String> requestIds;

  const RequestWorkSheetState({
    this.requestIds = const [],
    this.mapRequests = const {},
  });

  @override
  List<Object?> get props => [mapRequests, requestIds];

  factory RequestWorkSheetState.fromJson(Map<String, dynamic> json) => _$RequestWorkSheetStateFromJson(json);

  Map<String, dynamic> toJson() => _$RequestWorkSheetStateToJson(this);
}
