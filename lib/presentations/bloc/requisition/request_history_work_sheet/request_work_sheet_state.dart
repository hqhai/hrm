import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'request_work_sheet_state.g.dart';

@CopyWith()
class RequestWorkSheetState extends Equatable {
  final Map<String, Request> mapRequests;
  final List<String> requestIds;

  const RequestWorkSheetState({
    this.requestIds = const [],
    this.mapRequests = const {},
  });

  @override
  List<Object?> get props => [mapRequests, requestIds];
}
