import 'package:base_app/common/enum/enum_config.dart';
import 'package:base_app/domain/entities/reqisition/request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';

part 'request_state.g.dart';

@CopyWith()
class RequestState extends Equatable {
  final RequestStatus status;
  final List<Request> requests;
  final List<Request> requestsByUser;
  final Request request;
  final int totalItems;

  const RequestState({
    this.requests = const [],
    this.requestsByUser = const [],
    this.request = const Request(id: '', createdUserId: ''),
    this.status = RequestStatus.init,
    this.totalItems = 0,
  });

  @override
  List<Object> get props => [status, request, requests, requestsByUser, totalItems];
}
